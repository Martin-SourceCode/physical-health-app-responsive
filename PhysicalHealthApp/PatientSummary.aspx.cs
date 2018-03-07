using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class PatientSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
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

                this.hdnPatientID.Value = id;

                GetPatientData(id);

                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        this.lblSummaryType.Text = "My Summary";
                        this.btnCreateNewTest.Visible = false;
                        this.btnBack.Visible = false;
                        if (id != Session["userID"].ToString())
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        break;
                    case "clinician":
                        this.lblSummaryType.Text = "Patient";
                        if (Session["userID"].ToString() != this.hdnMatchedclinicianid.Value)
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        break;
                    case "super user":
                        Response.Redirect("Unauthorised.aspx");
                        break;
                }

                BindDropDownList(this.ddltesttypeid, "SELECT * FROM app_testtype ORDER BY testtypename", "testtypeid", "testtypename", 0);

                BindMyResults();
                BindMyNewResults();

            }
        }

        private void BindMyResults()
        {
            string sql = "SELECT * FROM app_test WHERE testtypeid = CAST(@testtypeid AS INT) AND patientid = CAST(@patientid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("testtypeid", this.ddltesttypeid.SelectedValue),
                new KeyValuePair<string, string>("patientid", this.hdnPatientID.Value)
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            this.dgAllMyResults.DataSource = dt;
            this.dgAllMyResults.DataBind();

            this.lblTestType.Text = this.ddltesttypeid.SelectedItem.Text;
            this.lblResultCount.Text = dt.Rows.Count.ToString();

            this.Chart1.DataSource = dt;
            //Give two columns of data to Y-axle 
            Chart1.Series[0].YValueMembers = "testnumericresult";
            Chart1.Series[0].XValueMember = "_createddate";

            

            Chart1.DataBind();

        }


        private void BindMyNewResults()
        {
            string sql = "SELECT a.testid, a.testnumericresult, b.testtypename, a._createddate FROM app_test a INNER JOIN app_testtype b ON a.testtypeid = b.testtypeid WHERE COALESCE(patienthasviewed,false) = false AND patientid = CAST(@patientid AS INT) ORDER BY a._createddate DESC;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("testtypeid", this.ddltesttypeid.SelectedValue),
                new KeyValuePair<string, string>("patientid", this.hdnPatientID.Value)
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            this.dgMyNewResults.DataSource = dt;
            this.dgMyNewResults.DataBind();

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

        protected void btnCreateNewTest_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNewPatientResult.aspx?id=" + this.hdnPatientID.Value);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void ddltesttypeid_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMyResults();
        }
    }
}