using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class CreateNewPatientResult : System.Web.UI.Page
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

                this.hdnPatientID.Value = id;

                this.lblError.Visible = false;

                GetPatientData(id);

                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        Response.Redirect("Unauthorised.aspx");
                        //this.lblSummaryType.Text = "My Summary";
                        //if (id != Session["userID"].ToString())
                        //{
                        //    Response.Redirect("Unauthorised.aspx");
                        //}
                        break;
                    case "clinician":
                        this.lblSummaryType.Text = "New Result";
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

                BindDropDownList(this.ddltesttypeid, "SELECT * FROM app_testtype ORDER BY testtypename", "testtypeid", "testtypename", 1);

                GetDefaultUnitsAndReferenceRange();
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

        protected void btnCreateNewTest_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNewPatientResult.aspx?id=" + this.hdnPatientID.Value);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("PatientSummary.aspx?id=" + this.hdnPatientID.Value);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string haserr = "form-group has-error";
            string noerr = "form-group";


            this.lblError.Text = string.Empty;
            this.lblError.Visible = false;
            this.fgtesttypeid.CssClass = noerr;
            this.fgtestnumericresult.CssClass = noerr;
            this.fgclinicianmessage.CssClass = noerr;
            this.fgnexttestdate.CssClass = noerr;
            this.fgclinicianhasapproved.CssClass = noerr;


            if (this.ddltesttypeid.SelectedIndex == 0)
            {
                this.lblError.Text = "Please select an test";
                this.lblError.Visible = true;
                this.fgtesttypeid.CssClass = haserr;
                return;
            }

            if (string.IsNullOrEmpty(this.txttestnumericresult.Text.ToString()))
            {
                this.lblError.Text = "Please enter the test result";
                this.lblError.Visible = true;
                this.fgtestnumericresult.CssClass = haserr;
                return;
            }
            else
            {
                Decimal d;
                try
                {
                    d = Convert.ToDecimal(this.txttestnumericresult.Text);
                }
                catch
                {
                    this.lblError.Text = "Please a numeric value for the test result";
                    this.lblError.Visible = true;
                    this.fgtestnumericresult.CssClass = haserr;
                    return;
                }
            }

            if (string.IsNullOrEmpty(this.txtnexttestdate.Text.ToString()))
            {
                this.lblError.Text = "Please enter the next test date";
                this.lblError.Visible = true;
                this.fgnexttestdate.CssClass = haserr;
                return;
            }
            else
            {
                DateTime DTm;
                try
                {
                    DTm = Convert.ToDateTime(this.txtnexttestdate.Text);
                }
                catch
                {
                    this.lblError.Text = "Please enter your next test date in the format dd/mm/yyyy";
                    this.lblError.Visible = true;
                    this.fgnexttestdate.CssClass = haserr;
                    return;
                }
            }

            if (string.IsNullOrEmpty(this.txtclinicianmessage.Text.ToString()))
            {
                this.lblError.Text = "Please enter your message to the patient";
                this.lblError.Visible = true;
                this.fgclinicianmessage.CssClass = haserr;
                return;
            }

            if (!this.chkclinicianhasapproved.Checked)
            {
                this.lblError.Text = "Please check the box to indicate that you have discussed the results with the patient";
                this.lblError.Visible = true;
                this.fgclinicianhasapproved.CssClass = haserr;
                return;
            }

            if (!string.IsNullOrEmpty(this.txtlowerreferencerange.Text.ToString()))
            {
                Decimal d;
                try
                {
                    d = Convert.ToDecimal(this.txtlowerreferencerange.Text);
                }
                catch
                {
                    this.lblError.Text = "Please a numeric value for the lower reference range";
                    this.lblError.Visible = true;
                    this.fglowerreferencerange.CssClass = haserr;
                    return;
                }
            }


            if (!string.IsNullOrEmpty(this.txtupperreferencerange.Text.ToString()))
            {
                Decimal d;
                try
                {
                    d = Convert.ToDecimal(this.txtupperreferencerange.Text);
                }
                catch
                {
                    this.lblError.Text = "Please a numeric value for the upper reference range";
                    this.lblError.Visible = true;
                    this.fgupperreferencerange.CssClass = haserr;
                    return;
                }
            }

            string sql = "INSERT INTO public.app_test(testtypeid, testnumericresult, lowerreferencerange, upperreferencerange, unitstext, testtextualresult, userid, patientid, clinicianhasapproved, clinianhasapproveddate, clinicianmessage, nexttestdate)";
            sql += "VALUES(CAST(@testtypeid AS INT), CAST(CASE WHEN COALESCE(@testnumericresult, '') = '' THEN NULL ELSE @testnumericresult END AS DECIMAL), CAST(CASE WHEN COALESCE(@lowerreferencerange, '') = '' THEN NULL ELSE @lowerreferencerange END AS DECIMAL), CAST(CASE WHEN COALESCE(@upperreferencerange, '') = '' THEN NULL ELSE @upperreferencerange END AS DECIMAL), @unitstext, @testtextualresult, CAST(@userid AS INT), CAST(@patientid AS INT), true, NOW(), @clinicianmessage, CAST(@nexttestdate AS DATE)); ";

            var paramListSave = new List<KeyValuePair<string, string>>() {
                    new KeyValuePair<string, string>("testtypeid", this.ddltesttypeid.SelectedValue),
                    new KeyValuePair<string, string>("testnumericresult", this.txttestnumericresult.Text),
                    new KeyValuePair<string, string>("lowerreferencerange",this.txtlowerreferencerange.Text),
                    new KeyValuePair<string, string>("upperreferencerange",this.txtupperreferencerange.Text),
                    new KeyValuePair<string, string>("unitstext",this.txtunitstext.Text),
                    new KeyValuePair<string, string>("testtextualresult", this.txttesttextualresult.Text),
                    new KeyValuePair<string, string>("userid", this.hdnUserId.Value),
                    new KeyValuePair<string, string>("patientid", this.hdnPatientID.Value),
                    new KeyValuePair<string, string>("clinicianmessage", this.txtclinicianmessage.Text),
                    new KeyValuePair<string, string>("nexttestdate", this.txtnexttestdate.Text)
                };
            DataServices.executeSQLStatement(sql, paramListSave);

            Response.Redirect("PatientSummary.aspx?id=" + this.hdnPatientID.Value);

        }

        protected void ddltesttypeid_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDefaultUnitsAndReferenceRange();
        }

        private void GetDefaultUnitsAndReferenceRange()
        {

            string sql = "SELECT * FROM app_testtype WHERE testtypeid = CAST(@testtypeid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                    new KeyValuePair<string, string>("testtypeid", this.ddltesttypeid.SelectedValue)
                };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];

            try
            {
                this.txtunitstext.Text = dt.Rows[0]["unitstext"].ToString();
            }
            catch { }

            try
            {
                this.txtlowerreferencerange.Text = dt.Rows[0]["lowerreferencerange"].ToString();
            }
            catch { }

            try
            {
                this.txtupperreferencerange.Text = dt.Rows[0]["upperreferencerange"].ToString();
            }
            catch { }

        }
    }
}
