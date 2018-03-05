using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class RegisterAsPatient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
              
                Page.Form.DefaultButton = this.btnRegister.UniqueID;
                Page.Form.DefaultFocus = this.ddlMatchedOrganisation.UniqueID;

                BindDropDownList(this.ddlMatchedOrganisation, "SELECT * FROM app_organisation ORDER BY organisationname", "organisationID", "organisationname", 1);
                BindDropDownList(this.ddlMatchedClinician, "SELECT * FROM activeclinician WHERE organisationid = " + this.ddlMatchedOrganisation.SelectedValue + " ORDER BY clinicianname", "userid", "clinicianname", 1);

                this.lblError.Visible = false;

                GetTnCs();

                this.divThankYou.Visible = false;
                this.divError.Visible = false;
                this.lblEmailError.Visible = false;

                Page.MaintainScrollPositionOnPostBack = true;
            }
        }

        private void SendEmail(string msg, string subject)
        {
            string msgStatus = "";

            int EmailStatus = EmailHelper.SendMail(msg, subject, this.hdnEmail.Value, out msgStatus);

            if (EmailStatus == 1)
            {
                this.divThankYou.Visible = true;
            }
            else
            {
                this.divThankYou.Visible = false;
                this.lblEmailError.Text = msgStatus;
                this.divError.Visible = true;
                this.lblEmailError.Visible = true;
            }

        }


        private void sendConfirmationEmail()
        {
            this.divThankYou.Visible = false;
            this.divError.Visible = false;
            this.lblEmailError.Visible = false;

            this.lblError.Text = string.Empty;
            this.lblError.Visible = false;

            string siteURL = GetSiteURL();

            string msg = "We have received a registration request to access the physical health site.<br /><br />";

            msg += "Please click the link below (or right click and copy link into your browser) to confirm your account:<br />";


            string emailLink = siteURL + "ConfirmAccount.aspx?id=";

            string emailvalidationstring = GetUserValidationString();

            //Build site url
            emailLink += emailvalidationstring;

            msg += "<h3>" + emailLink + "</h3></br />";

            string subject = "Confirmation Email";

            SendEmail(msg, subject);


        }


        private string GetSiteURL()
        {
            string sql = "SELECT * FROM systemsetup WHERE systemsetupid = 1;";
            string siteURL = "";

            DataSet ds = DataServices.DataSetFromSQL(sql, null);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                try { siteURL = dt.Rows[0]["siteurl"].ToString(); } catch { }
            }

            return siteURL;
        }

        private string GetUserValidationString()
        {

            string emailvalidationstring = "";
            string sql = "SELECT * FROM app_user WHERE emailaddress = @email;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("email", this.txtRegistrationEmail.Text)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                try { emailvalidationstring = dt.Rows[0]["emailvalidationstring"].ToString(); } catch { }


            }


            return emailvalidationstring;

        }

        private void GetTnCs()
        {
            string sql = "SELECT * FROM systemsetup WHERE systemsetupid = 1;";

            DataSet ds = DataServices.DataSetFromSQL(sql, null);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                try { this.lblTermsAndConditions.Text = dt.Rows[0]["patienttermsandconditions"].ToString(); } catch { }      
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)

        {

            string haserr = "form-group has-error";            
            string noerr = "form-group";


            this.lblError.Text = string.Empty;
            this.lblError.Visible = false;
            this.fgEmail.CssClass = noerr;
            this.fgPassword.CssClass = noerr;
            this.fgEmail.CssClass = noerr;
            this.fgPassword.CssClass = noerr;
            this.fgConfirmPassword.CssClass = noerr;
            this.fgMatchedOrganisation.CssClass = noerr;
            this.fgMatchedClinician.CssClass = noerr;

            this.fgFirstName.CssClass = noerr;
            this.fgLastName.CssClass = noerr;
            this.fgDOB.CssClass = noerr;

            this.fgTnCs.CssClass = noerr;

            if (this.ddlMatchedOrganisation.SelectedIndex == 0)
            {
                this.lblError.Text = "Please select an organisation";
                this.lblError.Visible = true;
                this.fgMatchedOrganisation.CssClass = haserr;
                return;
            }

            if (this.ddlMatchedClinician.SelectedIndex == 0)
            {
                this.lblError.Text = "Please select a clinician";
                this.lblError.Visible = true;
                this.fgMatchedClinician.CssClass = haserr;
                return;
            }

            if (string.IsNullOrEmpty(this.txtFirstName.Text.ToString()))
            {
                this.lblError.Text = "Please enter your first name";
                this.lblError.Visible = true;
                this.fgFirstName.CssClass = haserr;
                return;
            }

            if (string.IsNullOrEmpty(this.txtLastName.Text.ToString()))
            {
                this.lblError.Text = "Please enter your last name";
                this.lblError.Visible = true;
                this.fgLastName.CssClass = haserr;
                return;
            }


            if (string.IsNullOrEmpty(this.txtDOB.Text.ToString()))
            {
                this.lblError.Text = "Please enter your date of birth";
                this.lblError.Visible = true;
                this.fgDOB.CssClass = haserr;
                return;                
            }
            else
            {
                DateTime DTm;
                try
                {
                    DTm = Convert.ToDateTime(this.txtDOB.Text);
                }
                catch
                {
                    this.lblError.Text = "Please enter your date of birth in the format dd/mm/yyyy";
                    this.lblError.Visible = true;
                    this.fgDOB.CssClass = haserr;
                    return;
                }
            }

            if (string.IsNullOrEmpty(this.txtRegistrationEmail.Text.ToString()))
            {
                this.lblError.Text = "Please enter your email address";
                this.lblError.Visible = true;
                this.fgEmail.CssClass = haserr;
                return;
            }

            if (CheckEmailAddress() == 1)
            {
                this.lblError.Text = "This email address has already been registered";
                this.lblError.Visible = true;
                this.fgEmail.CssClass = haserr;
                return;
            }

            if (string.IsNullOrEmpty(this.txtRegistrationPassword.Text.ToString()))
            {
                this.lblError.Text = "Please enter a password";
                this.lblError.Visible = true;
                this.fgPassword.CssClass = haserr;
                return;
            }

            if (string.IsNullOrEmpty(this.txtConfirmPassword.Text.ToString()))
            {
                this.lblError.Text = "Please confirm your password";
                this.lblError.Visible = true;
                this.fgConfirmPassword.CssClass = haserr;
                return;
            }

            if (this.txtRegistrationPassword.Text != this.txtConfirmPassword.Text)
            {
                this.lblError.Text = "Passwords do not match";
                this.lblError.Visible = true;
                this.fgConfirmPassword.CssClass = haserr;
                this.fgPassword.CssClass = haserr;
                return;
            }


            if (!this.chkAcceptTnCs.Checked)
            {
                this.lblError.Text = "Please accept the terms and conditions";
                this.lblError.Visible = true;
                this.fgTnCs.CssClass = haserr;                
                return;
            }

            string sql = "INSERT INTO app_user(usertype, userpassword, matchedorganisationid, matchedclinicianid, nhsnumber, emailaddress, firstname, lastname, dateofbirth, acceptedtermsandconditions)";
            sql += " VALUES (@usertype, crypt(@userpassword, gen_salt('bf', 8)), CAST(@matchedorganisationid AS INT), CAST(@matchedclinicianid AS INT), @nhsnumber, @emailaddress, @firstname, @lastname, CAST(@dateofbirth AS date), CAST(@acceptedtermsandconditions AS BOOL))";

            string acceptedtermsandconditions = "False";
            if(this.chkAcceptTnCs.Checked)
            {
                acceptedtermsandconditions = "True";
            }
            var paramListSave = new List<KeyValuePair<string, string>>() {
                    new KeyValuePair<string, string>("usertype", this.ddlUserType.SelectedValue),
                    new KeyValuePair<string, string>("userpassword", this.txtRegistrationPassword.Text),
                    new KeyValuePair<string, string>("matchedorganisationid",this.ddlMatchedOrganisation.SelectedValue),
                    new KeyValuePair<string, string>("matchedclinicianid",this.ddlMatchedClinician.SelectedValue),
                    new KeyValuePair<string, string>("nhsnumber", this.txtNHSNo.Text),
                    new KeyValuePair<string, string>("emailaddress", this.txtRegistrationEmail.Text),
                    new KeyValuePair<string, string>("firstname", this.txtFirstName.Text),
                    new KeyValuePair<string, string>("lastname", this.txtLastName.Text),
                    new KeyValuePair<string, string>("dateofbirth", this.txtDOB.Text),
                    new KeyValuePair<string, string>("acceptedtermsandconditions", acceptedtermsandconditions)
                };
            DataServices.executeSQLStatement(sql, paramListSave);

            this.hdnEmail.Value = this.txtRegistrationEmail.Text;

            sendConfirmationEmail();

            Response.Redirect("RegistrationThankYou.aspx?id=patient");


        }


        private int CheckEmailAddress()
        {
            /*
             * 0 Okay
             * 1 Email exists
             * 2 Email not correct extension
             */

            string sql = "SELECT * from app_user where emailaddress = @email;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("email", this.txtRegistrationEmail.Text),
                
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                return 1;
            }
            else
            {
                return 0;
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

        protected void ddlMatchedOrganisation_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDownList(this.ddlMatchedClinician, "SELECT * FROM activeclinician WHERE organisationid = " + this.ddlMatchedOrganisation.SelectedValue + " ORDER BY clinicianname", "userid", "clinicianname", 1);
        }
    }
}