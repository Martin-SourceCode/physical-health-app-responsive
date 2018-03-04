using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.divThankYou.Visible = false;
                this.divError.Visible = false;
                this.lblEmailError.Visible = false;
                this.lblError.Visible = false;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            this.divThankYou.Visible = false;
            this.divError.Visible = false;
            this.lblEmailError.Visible = false;

            this.lblError.Text = string.Empty;
            this.lblError.Visible = false;

            this.txtEmail.CssClass = this.txtEmail.CssClass.Replace("has-error", "");
            this.fgtxtEmail.CssClass = this.fgtxtEmail.CssClass.Replace("has-error", "");


            if (string.IsNullOrEmpty(this.txtEmail.Text.ToString()))
            {
                this.lblError.Text = "Please enter your email address";
                this.lblError.Visible = true;
                this.fgtxtEmail.CssClass = this.fgtxtEmail.CssClass.Replace("form-group", "form-group has-error");
                return;
            }
            else
            {
                //Show the success message anyway so as not to give away user does not exist
                this.divThankYou.Visible = true;
            }



            string siteURL = GetSiteURL();

            string msg = "We have received a request to reset your password.<br /><br />";

            msg += "Please click the link below (or right click and copy link into your browser) to create your new password:<br />";


            string emailLink = siteURL + "ResetPasswordFromLink.aspx?id=";

            string emailvalidationstring = "";
            if (ValidateUser(out emailvalidationstring))
            {
                //Build site url
                siteURL += emailvalidationstring;

                msg += "<h3>" + siteURL + "</h3></br />";
               
                SendEmail(msg);

            }


        }

        private void SendEmail(string msg)
        {
            string msgStatus = "";

            int EmailStatus = EmailHelper.SendMail(msg, "Reset Password", this.txtEmail.Text, out msgStatus);

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

        private bool ValidateUser(out string emailvalidationstring)
        {

            emailvalidationstring = "";
            string sql = "SELECT * FROM app_user WHERE emailaddress = @email;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("email", this.txtEmail.Text)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                try { emailvalidationstring = dt.Rows[0]["emailvalidationstring"].ToString(); } catch { }

                return true;
            }


            return false;

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
    }
}