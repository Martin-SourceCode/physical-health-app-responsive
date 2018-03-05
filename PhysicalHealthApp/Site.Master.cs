using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = null;
            try
            {
                dt = (Session["UserDetailsSxn"]) as DataTable;
            }
            catch
            {
                dt = null;
            }


            if (dt == null)
            {
                Response.Redirect("Logout.aspx");
            }

         

        }
    }
}