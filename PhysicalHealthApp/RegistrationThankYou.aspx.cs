using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class RegistrationThankYou : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = "";

            try { id = Convert.ToString(Request.QueryString["id"].ToString()); }
            catch { }

            string authoriserType = "doctor";

            if(id.ToLower() == "patient")
            {
                authoriserType = "doctor";
            }

            if (id.ToLower() == "clinician")
            {
                authoriserType = "organisation administrator";
            }

            this.lblAccountAdministrator.Text = authoriserType;

        }
    }
}