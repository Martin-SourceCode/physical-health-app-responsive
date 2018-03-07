using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class Authorise : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = "";
                try
                {
                    id = Request.QueryString["id"].ToString();
                }
                catch
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                this.hdnSelectedUserID.Value = id;
               

                GetUserData(id);

                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        Response.Redirect("Unauthorised.aspx");
                        break;
                    case "clinician":                          
                        if (Session["userID"].ToString() != this.hdnMatchedclinicianid.Value)
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        this.lblUniqueIDName.Text = "NHS Number";
                        break;
                    case "super user":
                        //Response.Redirect("Unauthorised.aspx");
                        this.lblUniqueIDName.Text = "GMC Number";
                        this.h4DoB.Visible = false;
                        break;
                }

                this.hdnUserId.Value = Session["userID"].ToString();

              
            }
        }

        //Drop Down Lists
        private void BindDropDownList(DropDownList ddl, string sql, string valueField, string displayField, int addPleaseSelect)
        {
            DataSet ds = DataServices.DataSetFromSQL(sql);
            ddl.DataSource = ds;
            ddl.DataValueField = valueField;
            ddl.DataTextField = displayField;
            ddl.DataBind();

            if (addPleaseSelect == 1)
            {
                ListItem[] items = new ListItem[1];
                items[0] = new ListItem("Please select ...", "0");
                ddl.Items.Insert(0, items[0]);
            }
        }

        private void SetDDLSource(DropDownList ddl, string val)
        {
            if (val.Length > 0)
            {
                int idx = 9999;

                try
                {
                    idx = ddl.Items.IndexOf(ddl.Items.FindByValue(val));
                }
                catch
                {
                    idx = 9999;
                }

                if (idx == 9999 || idx < 0)
                {
                    ListItem[] items = new ListItem[1];
                    items[0] = new ListItem(val + " (old value)", val);
                    ddl.Items.Insert(1, items[0]);
                }
            }

            ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(val));
        }

        //RadioButtonList
        private void BindRadioList(RadioButtonList rad, string sql, string valueField, string displayField)
        {
            DataSet ds = DataServices.DataSetFromSQL(sql);
            rad.DataSource = ds;
            rad.DataValueField = valueField;
            rad.DataTextField = displayField;
            rad.DataBind();

        }

        private void SetRadioSource(RadioButtonList rad, string val)
        {
            rad.SelectedIndex = rad.Items.IndexOf(rad.Items.FindByValue(val));
        }


        private void GetUserData(string id)
        {
            string sql = "SELECT * FROM app_user WHERE userid = CAST(@userid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("userid", id)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {

                string userFullName = dt.Rows[0]["firstname"].ToString() + " " + dt.Rows[0]["lastname"].ToString();
                try
                {
                    this.lblUserFullName.Text = userFullName.ToUpper();
                }
                catch { }


                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":                        
                        break;
                    case "clinician":
                        try
                        {
                            this.lblUniqueID.Text = dt.Rows[0]["nhsnumber"].ToString();
                        }
                        catch { }
                        break;
                    case "super user":                        
                        try
                        {
                            this.lblUniqueID.Text = dt.Rows[0]["nhsnumber"].ToString();
                        }
                        catch { }
                        break;
                }
              
                try
                {
                    this.lblDoB.Text = dt.Rows[0]["dateofbirth"].ToString().Substring(0, 10); ;
                }
                catch { }

                try
                {
                    this.lblUserType.Text = dt.Rows[0]["usertype"].ToString();
                }
                catch { }

                try
                {
                    this.hdnEmail.Value = dt.Rows[0]["emailaddress"].ToString();
                }
                catch { }

                try
                {
                    this.hdnMatchedclinicianid.Value = dt.Rows[0]["matchedclinicianid"].ToString();
                }
                catch { }

                string currentStatus = "Currently Unauthorised";
                string currentStatusClass = "alert alert-info";

                bool isAuthorised = false;
                try
                {
                    isAuthorised = System.Convert.ToBoolean(dt.Rows[0]["isauthorised"].ToString());
                }
                catch { }

                bool isRejected = false;
                try
                {
                    isRejected = System.Convert.ToBoolean(dt.Rows[0]["isrejected"].ToString());
                }
                catch { }

                if(isAuthorised)
                {
                    currentStatus = "Currently Authorised";
                    currentStatusClass = "alert alert-success";
                    this.btnAuthorise.Visible = false;
                    //this.btnReject.Visible = false;
                }

                if (isRejected)
                {
                    currentStatus = "Currently Rejected";
                    currentStatusClass = "alert alert-danger";
                    this.btnReject.Visible = false;
                }

                this.lblCurrentStatus.Text = currentStatus;
                this.pnlCurrentStatus.CssClass = currentStatusClass;

            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnAuthorise_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE public.app_user SET isauthorised = true, authorisedtimestamp = NOW(), authorisedby = @currentuser, isrejected = false, rejectedtimestamp = null, rejectedby = null WHERE userid = CAST(@userid AS INT) ";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("@currentuser", this.hdnUserId.Value),
                new KeyValuePair<string, string>("@userid", this.hdnSelectedUserID.Value),
            };

            DataServices.executeSQLStatement(sql, paramList);

            buildEmailMessage("accepted");

            Response.Redirect("Default.aspx");
            
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE public.app_user SET isauthorised = false, authorisedtimestamp = null, authorisedby = null, isrejected = true, rejectedtimestamp = NOW(), rejectedby = @currentuser WHERE userid = CAST(@userid AS INT) ";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("@currentuser", this.hdnUserId.Value),
                new KeyValuePair<string, string>("@userid", this.hdnSelectedUserID.Value),
            };

            DataServices.executeSQLStatement(sql, paramList);

            buildEmailMessage("rejected");

            Response.Redirect("Default.aspx");
        }

        private void SendEmail(string msg, string subject)
        {
            string msgStatus = "";

            int EmailStatus = EmailHelper.SendMail(msg, subject, this.hdnEmail.Value, out msgStatus);
           

        }


        private void buildEmailMessage(string status)
        {


            string msg = "Your request to acces physical health site has been " + status + ".<br /><br />";

            string subject = "Request " + status;

            SendEmail(msg, subject);

        }
        
    }
}