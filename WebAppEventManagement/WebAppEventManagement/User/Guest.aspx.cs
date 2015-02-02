using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace WebAppEventManagement
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {

            //Search
            if (TextBoxEvName.Text != "")
            {
                TextBoxFname.Enabled = false;
                TextBoxLName.Enabled = false;
                TextBoxEmail.Enabled = false;
                try
                {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE EventName=@name";
                    SqlDataSource1.SelectParameters.Add("name", TextBoxEvName.Text);
                }
                catch (SqlException ol)
                {
                    lblErr.Text = ol.Message.ToString();
                }

            }

                if (TextBoxFname.Text != "")
            {
                TextBoxEvName.Enabled = false;
                TextBoxLName.Enabled = false;
                TextBoxEmail.Enabled = false;
                try
                {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE GuestFirstName=@fname";
                    SqlDataSource1.SelectParameters.Add("fname", TextBoxFname.Text);
                }
                catch (SqlException ol)
                {
                    lblErr.Text = ol.Message.ToString();
                }
            }

                if (TextBoxLName.Text != "")
                 {
                    TextBoxEvName.Enabled = false;
                    TextBoxFname.Enabled = false;
                    TextBoxEmail.Enabled = false;
                    try
                    {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE GuestLastName=@lname";
                    SqlDataSource1.SelectParameters.Add("lname", TextBoxLName.Text);
                    }
                    catch (SqlException ol)
                    {
                        lblErr.Text = ol.Message.ToString();
                    }
                }


                     if (TextBoxEmail.Text != "")
                 {
                    TextBoxEvName.Enabled = false;
                    TextBoxFname.Enabled = false;
                    TextBoxLName.Enabled = false;
                    try
                    {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE Email=@email";
                    SqlDataSource1.SelectParameters.Add("email", TextBoxEmail.Text);
                    }
                    catch (SqlException ol)
                    {
                        lblErr.Text = ol.Message.ToString();
                    }
                }
        }

        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            TextBoxEvName.Text = "";
            TextBoxFname.Text = "";
            TextBoxLName.Text = ""; ;
            TextBoxEmail.Text = "";
            try
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events";
            }
            catch (SqlException se)
            {
                lblErr.Text = se.Message.ToString();
            }
        }
    }
}