using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string redirectURL = "";

                try { redirectURL = Convert.ToString(Request.QueryString["redirectURL"].ToString()); }
                catch { redirectURL = "Default.aspx"; }

                this.lblRedirect.Text = redirectURL;

                String loggedInUser = "";
                try
                {
                    loggedInUser = Session["userID"].ToString();
                }
                catch { }

                if (loggedInUser.Length > 0)
                {
                    Response.Redirect(redirectURL);
                }

                Page.Form.DefaultButton = btnLogin.UniqueID;
                Page.Form.DefaultFocus = this.txtEmail.UniqueID;

                this.lblError.Visible = false;
                this.btnResendValidationEmail.Visible = false;

                string msgStatus = "";
                
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            this.lblError.Text = string.Empty;
            this.lblError.Visible = false;
            this.btnResendValidationEmail.Visible = false;

            this.txtEmail.CssClass = this.txtEmail.CssClass.Replace("has-error", "");
            this.txtPassword.CssClass = this.txtPassword.CssClass.Replace("has-error", "");
            this.fgtxtEmail.CssClass = this.fgtxtEmail.CssClass.Replace("has-error", "");
            this.fgtxtPassword.CssClass = this.fgtxtPassword.CssClass.Replace("has-error", "");

            if (string.IsNullOrEmpty(this.txtEmail.Text.ToString()))
            {
                this.lblError.Text = "Please enter your email address";
                this.lblError.Visible = true;
                this.fgtxtEmail.CssClass = this.fgtxtEmail.CssClass.Replace("form-group", "form-group has-error");
                return;
            }

            if (string.IsNullOrEmpty(this.txtPassword.Text.ToString()))
            {
                this.lblError.Text = "Please enter your password";
                this.lblError.Visible = true;
                this.fgtxtPassword.CssClass = this.fgtxtPassword.CssClass.Replace("form-group", "form-group has-error");
                return;
            }


            string IPAddress = "";
            try
            {
                IPAddress = GetIPAddress();
            }
            catch { }

            string sql = "SELECT * FROM app_user WHERE emailaddress = @email AND userpassword = crypt(@password, userpassword);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("email", this.txtEmail.Text),
                new KeyValuePair<string, string>("password", this.txtPassword.Text)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                //Valid User
                Session["UserDetailsSxn"] = dt;

                //Record Login
                string userid = "0";
                try
                {
                    userid = dt.Rows[0]["userid"].ToString();
                }
                catch { }

                Session["userID"] = userid;

                string emailconfirmed = "False";
                try
                {
                    emailconfirmed = dt.Rows[0]["emailconfirmed"].ToString();
                }
                catch { }

                if (emailconfirmed == "False")
                {
                    this.lblError.Text = "Your account has been created but you have not confirmed your email address yet.<br /><br />Please check your spam folder for the email containing the link to confirm your account";
                    this.btnResendValidationEmail.Visible = true;
                    this.lblError.Visible = true;                    
                    return;
                }

                string isauthorised = "False";
                try
                {
                    isauthorised = dt.Rows[0]["isauthorised"].ToString();
                }
                catch { }

                if (isauthorised == "False")
                {
                    this.lblError.Text = "Your account hasnot been authorised yet";
                    this.lblError.Visible = true;
                    return;
                }

                sql = "INSERT INTO loginhistory (userid, emailaddress, ipaddress) VALUES (CAST(@userid AS INT), @emailaddress, @ipaddress);";
                var paramListHistory = new List<KeyValuePair<string, string>>() {
                    new KeyValuePair<string, string>("userid", userid),
                    new KeyValuePair<string, string>("emailaddress", this.txtEmail.Text),
                    new KeyValuePair<string, string>("ipaddress",IPAddress)
                };
                DataServices.executeSQLStatement(sql, paramListHistory);

                Response.Redirect(this.lblRedirect.Text);
            }
            else
            {

               




                //Invalid User
                sql = "INSERT INTO failedlogin(emailaddress, ipaddress)	VALUES ( @emailaddress, @ipaddress); ";
                var paramListFail = new List<KeyValuePair<string, string>>() {
                    new KeyValuePair<string, string>("emailaddress", this.txtEmail.Text),
                    new KeyValuePair<string, string>("ipaddress",IPAddress)
                };
                DataServices.executeSQLStatement(sql, paramListFail);
                this.lblError.Text = "Invalid Username or Password";
                this.lblError.Visible = true;
            }
        }

        private string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }



    }

}