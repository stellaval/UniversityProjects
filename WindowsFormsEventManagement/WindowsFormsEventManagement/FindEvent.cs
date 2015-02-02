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
    public partial class FindEvent : Form
    {
   

        public FindEvent()
        {
            InitializeComponent();
            
            

        }

        private void FindEvent_Load(object sender, EventArgs e)
        {

            textBox6.Enabled = false;
            comboBox3.Enabled = false;
            comboBox2.Enabled = false;

            // TODO: This line of code loads data into the 'eventManagementDataSet5.Events' table. You can move, or remove it, as needed.
            this.eventsTableAdapter.Fill(this.eventManagementDataSet5.Events);
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

        private void button1_Click(object sender, EventArgs e)
        {
            if(textBox1.Text == "" && comboBox1.Text=="")
            {
                eventsBindingSource.Filter = "Place LIKE '%" + textBox4.Text + "%'";
            }
            else if (textBox4.Text == "" && comboBox1.Text == "")
            {
                eventsBindingSource.Filter = "EventName LIKE '%"+textBox1.Text+"%'";
            }
            else if (textBox1.Text != "" && textBox4.Text != "" && comboBox1.Text=="")
            {
                eventsBindingSource.Filter = "EventName LIKE '%" + textBox1.Text + "%' OR Place LIKE '%" + textBox4.Text + "%'";
            }
            else if (textBox1.Text == "" && textBox4.Text == "" && comboBox1.Text != "")
            {
                eventsBindingSource.Filter = "EventType = "+comboBox1.SelectedValue+"";
            }
            else if (textBox1.Text != "" && textBox4.Text == "" && comboBox1.Text != "")
            {
                eventsBindingSource.Filter = "EventName LIKE '%" + textBox1.Text + "%' OR EventType =" + comboBox1.SelectedValue + "";
            }
            else if (textBox1.Text == "" && textBox4.Text != "" && comboBox1.Text != "")
            {
                eventsBindingSource.Filter = "Place LIKE '%" + textBox4.Text + "%' OR EventType =" + comboBox1.SelectedValue + ""; 
            }
            else if (textBox1.Text != "" && textBox4.Text != "" && comboBox1.Text != "")
            {
                eventsBindingSource.Filter = "EventName LIKE '%" + textBox1.Text + "%' OR Place LIKE '%" + textBox4.Text + "%' OR EventType =" + comboBox1.SelectedValue + "";
            }

            //SqlConnection connection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True");
            //connection.Open();
            //SqlCommand command = connection.CreateCommand();
            //command.CommandType = CommandType.Text;
            //command.CommandText = "select * from Events where EventName like '%"+textBox1.Text+"%' or Place like '%"+textBox4.Text+"%'";
            //command.ExecuteNonQuery();
            //DataTable dt = new DataTable();
            //SqlDataAdapter da = new SqlDataAdapter(command);
            //da.Fill(dt);
            //dataGridView1.DataSource = dt;

            //connection.Close();



        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
            textBox4.Text = "";
            textBox6.Text = "";
            comboBox1.SelectedIndex = -1;
            comboBox2.SelectedIndex = -1;
            comboBox3.SelectedIndex = -1;

        }

        private void button3_Click(object sender, EventArgs e)
        {
            NewEvent newEvent = new NewEvent();
            newEvent.MdiParent = MDIParent1.ActiveForm;
            newEvent.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {

           

                EditEvent editEvent = new EditEvent();
                editEvent.eventName = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
                editEvent.eventType = (int)dataGridView1.SelectedRows[0].Cells[1].Value;
                editEvent.eventTeam = (int)dataGridView1.SelectedRows[0].Cells[2].Value;
                editEvent.eventClient = (int)dataGridView1.SelectedRows[0].Cells[3].Value;
                editEvent.eventPlace = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();
                editEvent.eventDate = dataGridView1.SelectedRows[0].Cells[5].Value.ToString();
                editEvent.eventTime = dataGridView1.SelectedRows[0].Cells[6].Value.ToString();
                editEvent.eventDescription = dataGridView1.SelectedRows[0].Cells[7].Value.ToString();
                editEvent.evetID = (int)dataGridView1.SelectedRows[0].Cells[8].Value;
                editEvent.ShowDialog();
            

        }

        private void button5_Click(object sender, EventArgs e)
        {
            DeleteEvent deleteEvent = new DeleteEvent();
            deleteEvent.eventNameD = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
            deleteEvent.eventTypeD = (int)dataGridView1.SelectedRows[0].Cells[1].Value;
            deleteEvent.eventTeamD = (int)dataGridView1.SelectedRows[0].Cells[2].Value;
            deleteEvent.eventClientD = (int)dataGridView1.SelectedRows[0].Cells[3].Value;
            deleteEvent.eventPlaceD = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();
            deleteEvent.eventDateD = dataGridView1.SelectedRows[0].Cells[5].Value.ToString();
            deleteEvent.eventTimeD = dataGridView1.SelectedRows[0].Cells[6].Value.ToString();
            deleteEvent.eventDescriptionD = dataGridView1.SelectedRows[0].Cells[7].Value.ToString();
            deleteEvent.evetIDD = (int)dataGridView1.SelectedRows[0].Cells[8].Value;
            deleteEvent.ShowDialog();
            
            //SqlConnection connection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=INSURANCE;Integrated Security=True");
            //using (connection)
            //{
            //    SqlCommand command = new SqlCommand("deletePolicy", connection);
            //    command.CommandType = CommandType.StoredProcedure;
            //    command.CommandText = "deletePolicy";

            //    SqlParameter id = new SqlParameter("@policyID", SqlDbType.Int);
            //    id.Value = dataGridView1.CurrentRow.Cells[0].Value;
            //    command.Parameters.Add(id);

            //    SqlParameter po_id = new SqlParameter("@po_id", SqlDbType.NVarChar);
            //    po_id.Direction = ParameterDirection.Output;
            //    command.Parameters.Add(po_id);

            //    try
            //    {
            //        connection.Open();
            //        SqlDataReader dr = command.ExecuteReader();
            //        int res = (Int32)command.Parameters["@po_id"].Value;
            //        if (res != 0)
            //        {
            //            MessageBox.Show("Deleted Successfully!");
            //        }
            //        else
            //        {
            //            MessageBox.Show("Nothing to delete!");
            //        }
            //    }
            //    catch (SqlException ex)
            //    {
            //        MessageBox.Show(ex.ToString());
            //    }

        }
    }
}
