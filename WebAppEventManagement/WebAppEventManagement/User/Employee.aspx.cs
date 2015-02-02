using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace WebAppEventManagement
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private SqlConnection CreateConnection()
        {
            string connectionString = @"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=WebAppEventManagement;Integrated Security=True";
            SqlConnection conn = new SqlConnection(connectionString);
            return conn;
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownListSearchPosition.SelectedIndex = -1;
            DropDownList1.SelectedIndex = -1;
        }

        protected void ButtonAdd_Click1(object sender, EventArgs e)
        {
              // add
            SqlConnection sqlConnection = CreateConnection();
            using (sqlConnection)
            {
                SqlCommand command = new SqlCommand("insertEmployees", sqlConnection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "insertEmployees";

                SqlParameter id = new SqlParameter("@id", SqlDbType.Int);
                id.Value = TextBoxID.Text;
                command.Parameters.Add(id);

                SqlParameter name = new SqlParameter("@FirstName", SqlDbType.NVarChar);
                name.Value = TextBoxFName.Text;
                command.Parameters.Add(name);

                SqlParameter lname= new SqlParameter("@LastName", SqlDbType.NVarChar);
                lname.Value = TextBoxEmLName.Text;
                command.Parameters.Add(lname);

                SqlParameter position = new SqlParameter("@Position", SqlDbType.Int);
                position.Value = DropDownList1.SelectedValue;
                command.Parameters.Add(position);

                SqlParameter email = new SqlParameter("@Email", SqlDbType.NVarChar);
                email.Value = TextBoxEmail.Text;
                command.Parameters.Add(email);

                SqlParameter phoneNumber = new SqlParameter("PhoneNumber", SqlDbType.NVarChar);
                phoneNumber.Value = TextBoxNr.Text;
                command.Parameters.Add(phoneNumber);

                try
                {
                    sqlConnection.Open();
                    command.ExecuteNonQuery();
                    LabelMess.Text = "Employee was entered successfully.";
                }
                catch (SqlException ol)
                {
                    LabelMess.Text = ol.Message.ToString();
                }
            }


        }

        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            TextBoxID.Text = "";
            TextBoxFName.Text = "";
            TextBoxEmLName.Text = "";
            DropDownList1.SelectedIndex = -1;
            TextBoxEmail.Text = "";
            TextBoxNr.Text = "";
        }



        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox1.Text = GridView1.SelectedRow.Cells[1].Text;
            TextBox2.Text = GridView1.SelectedRow.Cells[2].Text;
            TextBox3.Text = GridView1.SelectedRow.Cells[3].Text;
            TextBox4.Text = GridView1.SelectedRow.Cells[4].Text;
            TextBox5.Text = GridView1.SelectedRow.Cells[5].Text;
            TextBox6.Text = GridView1.SelectedRow.Cells[6].Text;
       
                

                
        }

            protected void Button1_Click(object sender, EventArgs e)
            {
                if (TextBoxSearchFname.Text != "" || TextBoxsearchLName.Text != "")
                {
                    DropDownListSearchPosition.SelectedIndex = -1;

                    try
                    {
                        SqlDataSource2.SelectParameters.Clear();
                        SqlDataSource2.SelectCommand = "SELECT * FROM Employee WHERE EmployeeFirtName=@firstName or EmployeeLastName=@lastName";
                        SqlDataSource2.SelectParameters.Add("firstName", TextBoxSearchFname.Text);
                        SqlDataSource2.SelectParameters.Add("lastName", TextBoxsearchLName.Text);

                    }
                    catch (SqlException ol)
                    {
                        lblErr.Text = ol.Message.ToString();
                    }
                    try
                    {
                        SqlDataSource2.SelectParameters.Clear();
                        SqlDataSource2.SelectCommand = "select * from Employee where PositionID=@posID";
                        SqlDataSource2.SelectParameters.Add("posID", DropDownListSearchPosition.SelectedValue);
                    }
                    catch (SqlException ex)
                    {
                        lblErr.Text = ex.Message.ToString();
                    }
                }
            }

            protected void Button3_Click(object sender, EventArgs e)
            {
                //Search
                if (TextBox7.Text != "")
                {
                    TextBox8.Enabled = false;
                    try
                    {
                        SqlDataSource5.SelectParameters.Clear();
                        SqlDataSource5.SelectCommand = "SELECT * FROM EmpEvent WHERE EventName=@evName";
                        SqlDataSource5.SelectParameters.Add("evName", TextBox7.Text);
                     
                    }
                    catch (SqlException ol)
                    {
                        lblErr.Text = ol.Message.ToString();
                    }
                }

                if (TextBox8.Text != "")
                {
                    TextBox7.Enabled = false;
                    try
                    {
                        SqlDataSource5.SelectParameters.Clear();
                        SqlDataSource5.SelectCommand = "SELECT * FROM EmpEvent WHERE EmployeeLastName=@empName";
                        SqlDataSource5.SelectParameters.Add("empName", TextBox8.Text);

                    }
                    catch (SqlException ol)
                    {
                        lblErr.Text = ol.Message.ToString();
                    }
                }
            }

            protected void Button4_Click(object sender, EventArgs e)
            {
                //clear
               
                TextBox7.Text = "";
                TextBox8.Text = "";
                TextBox8.Enabled = true;
                TextBox7.Enabled = true;
                
                try
                {
                    SqlDataSource5.SelectCommand = "SELECT * FROM EmpEvent";
                }
                catch (SqlException se)
                {
                    lblErr.Text=se.Message.ToString();
                }
                
            }

            protected void Button5_Click(object sender, EventArgs e)
            {
                SqlConnection sqlConnection = CreateConnection();
                    using (sqlConnection)
                    {
                        SqlCommand commandUpdate = new SqlCommand("updateEmployees", sqlConnection);
                        commandUpdate.CommandType = CommandType.StoredProcedure;
                        commandUpdate.CommandText = "updateEmployees";

                        SqlParameter emId = new SqlParameter("@EmployeeID", SqlDbType.Int);
                        emId.Value = TextBox1.Text;
                        commandUpdate.Parameters.Add(emId);

                        SqlParameter firstName = new SqlParameter("@FirstName", SqlDbType.NVarChar);
                        firstName.Value = TextBox2.Text;
                        commandUpdate.Parameters.Add(firstName);

                        SqlParameter lastName = new SqlParameter("@LastName", SqlDbType.NVarChar);
                        lastName.Value = TextBox3.Text;
                        commandUpdate.Parameters.Add(lastName);

                        SqlParameter position = new SqlParameter("@Position", SqlDbType.NVarChar);
                        position.Value = TextBox4.Text;
                        commandUpdate.Parameters.Add(position);

                        SqlParameter email = new SqlParameter("@Email", SqlDbType.NVarChar);
                        email.Value = TextBox5.Text;
                        commandUpdate.Parameters.Add(email);

                        SqlParameter phoneNumber = new SqlParameter("@PhoneNumber", SqlDbType.NVarChar);
                        phoneNumber.Value = TextBox6.Text;
                        commandUpdate.Parameters.Add(phoneNumber);
                    }
            }

        //        if (TextBoxFname.Text != "")
        //    {
        //        TextBoxEvName.Enabled = false;
        //        TextBoxLName.Enabled = false;
        //        TextBoxEmail.Enabled = false;
        //        try
        //        {
        //            SqlDataSource1.SelectParameters.Clear();
        //            SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE GuestFirstName=@fname";
        //            SqlDataSource1.SelectParameters.Add("fname", TextBoxFname.Text);
        //        }
        //        catch (SqlException ol)
        //        {
        //            lblErr.Text = ol.Message.ToString();
        //        }
        //    }

        //        if (TextBoxLName.Text != "")
        //         {
        //            TextBoxEvName.Enabled = false;
        //            TextBoxFname.Enabled = false;
        //            TextBoxEmail.Enabled = false;
        //            try
        //            {
        //            SqlDataSource1.SelectParameters.Clear();
        //            SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE GuestLastName=@lname";
        //            SqlDataSource1.SelectParameters.Add("lname", TextBoxLName.Text);
        //            }
        //            catch (SqlException ol)
        //            {
        //                lblErr.Text = ol.Message.ToString();
        //            }
        //        }


        //             if (TextBoxEmail.Text != "")
        //         {
        //            TextBoxEvName.Enabled = false;
        //            TextBoxFname.Enabled = false;
        //            TextBoxLName.Enabled = false;
        //            try
        //            {
        //            SqlDataSource1.SelectParameters.Clear();
        //            SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events WHERE Email=@email";
        //            SqlDataSource1.SelectParameters.Add("email", TextBoxEmail.Text);
        //            }
        //            catch (SqlException ol)
        //            {
        //                lblErr.Text = ol.Message.ToString();
        //            }
        //        }
        //}

        //protected void ButtonClear_Click(object sender, EventArgs e)
        //{
        //    TextBoxEvName.Text = "";
        //    TextBoxFname.Text = "";
        //    TextBoxLName.Text = ""; ;
        //    TextBoxEmail.Text = "";
        //    try
        //    {
        //        SqlDataSource1.SelectCommand = "SELECT * FROM Guests@Events";
        //    }
        //    catch (SqlException se)
        //    {
        //        lblErr.Text = se.Message.ToString();
        //    }
        //}
        //    } 
    }
}

        //protected void ButtonClear_Click(object sender, EventArgs e)
        //{
        //    //clear

        //    DropDownList3.SelectedIndex = -1;
        //    DropDownList4.SelectedIndex = -1;
        //    DropDownList3.Enabled = true;
        //    DropDownList4.Enabled = true;
        //    try
        //    {
        //        SqlDataSource4.SelectCommand = "SELECT * FROM EventEmployee";
        //    }
        //    catch (SqlException se)
        //    {
        //        lblErr.Text = se.Message.ToString();
        //    }
        //}

        //protected void ButtonSearch_Click(object sender, EventArgs e)
        //{

        //    //Search
        //    if (DropDownList3.SelectedIndex != -1)
        //    {
        //        DropDownList4.Enabled = false;

        //        try
        //        {
        //            SqlDataSource2.SelectParameters.Clear();
        //            SqlDataSource2.SelectCommand = "SELECT * FROM EventEmployee WHERE EventID=@id";
        //            SqlDataSource2.SelectParameters.Add("id", DropDownList3.SelectedValue);
        //        }
        //        catch (SqlException ol)
        //        {
        //            lblErr.Text = ol.Message.ToString();
        //        }

        //        if (DropDownList4.SelectedIndex != -1)
        //        {
        //            DropDownList3.Enabled = false;

        //            try
        //            {
        //                SqlDataSource2.SelectParameters.Clear();
        //                SqlDataSource2.SelectCommand = "SELECT * FROM EventEmployee WHERE EmployeeID=@id";
        //                SqlDataSource2.SelectParameters.Add("id", DropDownList4.SelectedValue);
        //            }
        //            catch (SqlException ol)
        //            {
        //                lblErr.Text = ol.Message.ToString();
        //            }
        //        }
        //    }
        //}

    


     
