using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class RegisterAs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegisterAsPatient_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsPatient.aspx");
        }

        protected void btnRegisterAsClinician_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsClinician.aspx");
        }
    }
}