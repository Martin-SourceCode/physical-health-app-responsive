using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PhysicalHealthApp
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            string add = "update Test set id = 1 where id = 11;";
            DataServices.executeSQLStatement(add, null);

            string sql = "SELECT * FROM Test ";
            

            DataSet ds = DataServices.DataSetFromSQL(sql);
            DataTable dt = ds.Tables[0];

            this.dgTest.DataSource = dt;
            this.dgTest.DataBind();

        }
    }
}