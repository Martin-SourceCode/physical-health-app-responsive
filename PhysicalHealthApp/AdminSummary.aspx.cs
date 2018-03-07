using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class AdminSummary : System.Web.UI.Page
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

                this.hdnClinicianID.Value = id;

                GetUserDataFromString(id);

                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        Response.Redirect("Unauthorised.aspx");
                        break;
                    case "clinician":
                        //this.lblSummaryType.Text = "My Summary";
                        //if (id != Session["userID"].ToString())
                        //{
                        //    Response.Redirect("Unauthorised.aspx");
                        //}
                        Response.Redirect("Unauthorised.aspx");
                        break;
                    case "super user":
                        //Response.Redirect("Unauthorised.aspx");
                        break;
                }

                BindDropDownList(this.ddlMatchedOrganisation, "SELECT * FROM app_organisation ORDER BY organisationname", "organisationID", "organisationname", 0);

                GetAllUsers();
                GetMyUnauthorisedUsers();
                GetMyRejectedUsers();

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

        private void GetAllUsers()
        {
            string sql = "SELECT * FROM app_user WHERE usertype='Clinician' AND organisationid =  CAST(@organisationid AS INT) AND isauthorised = true ORDER BY firstname, lastname;";
            var paramList = new List<KeyValuePair<string, string>>()
            {
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            this.dgMyPatients.DataSource = dt;
            this.dgMyPatients.DataBind();
            this.lblAllPatientCount.Text = dt.Rows.Count.ToString();

        }

        private void GetMyUnauthorisedUsers()

        {
            string sql = "SELECT * FROM app_user WHERE usertype='Clinician' AND organisationid =  CAST(@organisationid AS INT) AND COALESCE(isauthorised, false) = false ORDER BY firstname, lastname;";
            var paramList = new List<KeyValuePair<string, string>>()
            {
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            this.dgMyUnauthorisedPatients.DataSource = dt;
            this.dgMyUnauthorisedPatients.DataBind();

            this.lblNewRequestCount.Text = dt.Rows.Count.ToString();

        }


        private void GetMyRejectedUsers()
        {
            string sql = "SELECT * FROM app_user WHERE usertype='Clinician' AND organisationid =  CAST(@organisationid AS INT) AND COALESCE(isrejected, false) = true ORDER BY firstname, lastname;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("organisationid", this.ddlMatchedOrganisation.SelectedValue)
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            this.dgMyRejectedRequests.DataSource = dt;
            this.dgMyRejectedRequests.DataBind();

            this.lbRejectedRequestCount.Text = dt.Rows.Count.ToString();

        }

        private void GetUserDataFromString(string id)
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
                    this.lblClinianName.Text = userFullName.ToUpper();
                }
                catch { }
            }
        }

        protected void ddlMatchedOrganisation_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetAllUsers();
            GetMyUnauthorisedUsers();
            GetMyRejectedUsers();
        }
    }
}