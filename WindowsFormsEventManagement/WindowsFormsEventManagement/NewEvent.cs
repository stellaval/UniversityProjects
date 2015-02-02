using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace WindowsFormsEventManagement
{
    public partial class NewEvent : Form
    {
        public NewEvent()
        {
            InitializeComponent();
        }

        private void NewEvent_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'eventManagementDataSet3.Clients' table. You can move, or remove it, as needed.
            this.clientsTableAdapter.Fill(this.eventManagementDataSet3.Clients);
            // TODO: This line of code loads data into the 'eventManagementDataSet2.Teams' table. You can move, or remove it, as needed.
            this.teamsTableAdapter.Fill(this.eventManagementDataSet2.Teams);
            // TODO: This line of code loads data into the 'eventManagementDataSet1.EventTypes' table. You can move, or remove it, as needed.
            this.eventTypesTableAdapter.Fill(this.eventManagementDataSet1.EventTypes);

            comboBox1.SelectedIndex = -1;
            comboBox2.SelectedIndex = -1;
            comboBox3.SelectedIndex = -1;


        }

        private void button4_Click(object sender, EventArgs e)
        {
           
            SqlConnection sqlConnection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True"); 

            using (sqlConnection)
           {
               SqlCommand command = new SqlCommand("insertEvent", sqlConnection);
               command.CommandType = CommandType.StoredProcedure;
               command.CommandText = "insertEvent";

                SqlParameter name = new SqlParameter("@EventName", SqlDbType.NVarChar);
                name.Value=textBox1.Text;
                command.Parameters.Add(name);

                SqlParameter type = new SqlParameter("@EventType", SqlDbType.Int);
                type.Value=comboBox1.SelectedValue;
                command.Parameters.Add(type);

                SqlParameter team = new SqlParameter("@Team", SqlDbType.Int);
                team.Value=comboBox2.SelectedValue;
                command.Parameters.Add(team);

                SqlParameter client =  new SqlParameter("@Client", SqlDbType.Int);
                client.Value=comboBox3.SelectedValue;
                command.Parameters.Add(client);

                SqlParameter place = new SqlParameter("@Place", SqlDbType.NVarChar);
                place.Value=textBox2.Text;
                command.Parameters.Add(place);

                SqlParameter date = new SqlParameter("@Date",SqlDbType.Date);
                date.Value=maskedTextBox1.Text;
                command.Parameters.Add(date);

                SqlParameter time = new SqlParameter("@Time", SqlDbType.Time);
                time.Value=maskedTextBox2.Text;
                command.Parameters.Add(time);

                SqlParameter description = new SqlParameter("@Description", SqlDbType.NVarChar);
                description.Value=textBox3.Text;
                command.Parameters.Add(description);

                try
               {
                   sqlConnection.Open();
                   command.ExecuteNonQuery();
                   MessageBox.Show("You have successfully entered company!");
               }
               catch (SqlException ol)
               {
                   MessageBox.Show(ol.ToString());
               }

            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            comboBox1.SelectedIndex = -1;
            comboBox2.SelectedIndex = -1;
            comboBox3.SelectedIndex = -1;
            maskedTextBox1.Text = "";
            maskedTextBox2.Text = "";
        }


    }
}
