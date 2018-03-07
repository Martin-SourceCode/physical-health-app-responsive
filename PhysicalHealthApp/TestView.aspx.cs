using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class TestView : System.Web.UI.Page
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

                this.hdnTestId.Value = id;

                GetTestData(id);

                //this.lblError.Visible = false;


                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        //Response.Redirect("Unauthorised.aspx");
                        //this.lblSummaryType.Text = "My Summary";



                        if (this.hdnPatientID.Value != Session["userID"].ToString())
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        else
                        {
                            //Update test to viewed by patient
                            string sql = "UPDATE app_test SET patienthasviewed = true, patientvieweddate = NOW() WHERE testid = CAST(@testid AS INT) AND COALESCE(patienthasviewed, false) = false;";
                            var paramList = new List<KeyValuePair<string, string>>() {
                                new KeyValuePair<string, string>("testid", id)
                            };
                            DataServices.executeSQLStatement(sql, paramList);

                        }
                        break;
                    case "clinician":
                        //this.lblSummaryType.Text = "New Result";
                        if (Session["userID"].ToString() != this.hdnMatchedclinicianid.Value)
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        break;
                    case "super user":
                        Response.Redirect("Unauthorised.aspx");
                        break;
                }

                this.hdnUserId.Value = Session["userID"].ToString();


            }
        }

        private void GetTestType(string id)
        {
            string sql = "SELECT * FROM app_testtype WHERE testtypeid = CAST(@testid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("testtypeid", id)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {


                try
                {
                    this.lbltesttypename.Text = dt.Rows[0]["testtypename"].ToString();
                }
                catch { }
            }
        }


        private void GetTestData(string id)
        {
            string sql = "SELECT * FROM app_test WHERE testid = CAST(@testid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("testid", id)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {

                string patientid = "";
                try
                {
                    patientid = dt.Rows[0]["patientid"].ToString();
                    this.hdnPatientID.Value = patientid;
                    GetPatientData(patientid);
                }
                catch { }

                string testtypeid = "";
                try
                {
                    testtypeid = dt.Rows[0]["testtypeid"].ToString();
                    GetTestType(testtypeid);
                }
                catch { }

                try
                {
                    this.lbltestnumericresult.Text = dt.Rows[0]["testnumericresult"].ToString();
                }
                catch { }

                try
                {
                    this.lblunitstext.Text = dt.Rows[0]["unitstext"].ToString();
                }
                catch { }

                try
                {
                    this.lbllowerreferencerange.Text = dt.Rows[0]["lowerreferencerange"].ToString();
                }
                catch { }

                try
                {
                    this.lblupperreferencerange.Text = dt.Rows[0]["upperreferencerange"].ToString();
                }
                catch { }

                try
                {
                    this.lblclinicianmessage.Text = dt.Rows[0]["clinicianmessage"].ToString();
                }
                catch { }

                try
                {
                    this.lblnexttestdate.Text = dt.Rows[0]["nexttestdate"].ToString().Substring(0, 10); ;
                }
                catch { }


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


        private void GetPatientData(string id)
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
                    this.lblPatientName.Text = userFullName.ToUpper();
                }
                catch { }

                try
                {
                    this.lblNHS.Text = dt.Rows[0]["nhsnumber"].ToString();
                }
                catch { }

                try
                {
                    this.lblDoB.Text = dt.Rows[0]["dateofbirth"].ToString().Substring(0, 10); ;
                }
                catch { }

                try
                {
                    this.hdnMatchedclinicianid.Value = dt.Rows[0]["matchedclinicianid"].ToString();
                }
                catch { }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("PatientSummary.aspx?id=" + this.hdnPatientID.Value);
        }
    }
}