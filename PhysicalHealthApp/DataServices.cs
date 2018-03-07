using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;

namespace PhysicalHealthApp
{
    internal class DataServices
    {


        public static void executeSQLStatement(string sql, List<KeyValuePair<string, string>> parameters = null)
        {

            //Read Database Credentials from Web.config
            NpgsqlConnection con = new NpgsqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PGSQLConnection"].ConnectionString);

            using (con)
            {
                con.Open();

                // Insert some data
                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = sql;
                    try
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.AddWithValue(param.Key, param.Value);
                        }
                    }
                    catch { }
                    cmd.ExecuteNonQuery();
                    

                }


            }


        }

        

        public static DataSet DataSetFromSQL(string sqlQueryString, List<KeyValuePair<string, string>> parameters = null)
        {
            NpgsqlConnection con = new NpgsqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PGSQLConnection"].ConnectionString);
            DataSet ds = new DataSet();

            using (con)
            {
                NpgsqlCommand cmd = new NpgsqlCommand();
                NpgsqlDataAdapter da = new NpgsqlDataAdapter();
                da.SelectCommand = cmd;
                cmd.CommandText = sqlQueryString;
                try
                {
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }
                }
                catch { }
                da.SelectCommand.Connection = con;
                da.Fill(ds);
            }

            return ds;


        }

        
    }
}