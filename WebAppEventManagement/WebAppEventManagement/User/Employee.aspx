<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Employee.aspx.cs" Theme="Skin1" Inherits="WebAppEventManagement.WebForm2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .style11
        {
            width: 609px;
        }
        .style12
        {
            width: 169px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Employees
</h2>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:TabContainer ID="TabContainer1" runat="server" Style="margin-right: 15px" ActiveTabIndex="0"
        Height="902px" Width="797px" CssClass="Tab">
        <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Employees Info">
            <ContentTemplate>
                <asp:Wizard runat="server" ActiveStepIndex="1" Height="73px" Width="450px" 
                    ID="Wizard1" SkinID="Skin1">
                    <WizardSteps>
                        <asp:WizardStep runat="server" ID="WizardStep1" Title="Add">
                            <table width="450px">
                                <tr>
                                <td class="style11"><asp:Label ID="Label1" runat="server" Text="Employee ID"></asp:Label></td>
                                 <td class="style12"><asp:TextBox ID="TextBoxID" runat="server"></asp:TextBox></td>
                                </tr>  
                                <tr><td class="style11"><asp:Label ID="Label2" runat="server" Text="First Name"></asp:Label></td>
                                    <td class="style12">
                                    <asp:TextBox
                                ID="TextBoxFName" runat="server" Width="120px"></asp:TextBox></td>
                                </tr>
                            <tr><td class="style11">
                            <asp:Label ID="Label3" runat="server" Text="Last Name "></asp:Label></td>
                                <td class="style12"><asp:TextBox
                                ID="TextBoxEmLName" runat="server"></asp:TextBox></td></tr>
                            <tr><td class="style11">
                            <asp:Label ID="Label4" runat="server" Text="Position"></asp:Label></td>
                                <td class="style12"><asp:DropDownList
                                ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="PositionName"
                                DataValueField="PositionID" Width="123px">
                            </asp:DropDownList>&nbsp;</td>
                            
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>"
                                SelectCommand="SELECT [PositionID], [PositionName] FROM [Position]"></asp:SqlDataSource>
                            </tr>
                            <tr><td class="style11">
                            <asp:Label ID="Label5" runat="server" Text="Email"></asp:Label></td>
                                <td class="style12"><asp:TextBox ID="TextBoxEmail"
                                runat="server"></asp:TextBox></td></tr>
                            <tr><td class="style11">
                            <asp:Label ID="Label6" runat="server" Text="Phone Number"></asp:Label></td>
                                <td class="style12"><asp:TextBox
                                ID="TextBoxNr" runat="server"></asp:TextBox></td></tr>
                            
                            </table>
                            <br />
                            <asp:Button ID="ButtonAdd" runat="server" Style="margin-left: 120px; margin-bottom: 0px"
                                Text="Add" Width="69px" OnClick="ButtonAdd_Click1" /><asp:Button ID="ButtonClear"
                                    runat="server" Text="Clear" Style="margin-left: 20px;" OnClick="ButtonClear_Click" /><br />
                            <asp:Label ID="LabelMess" runat="server" Text="Message"></asp:Label></asp:WizardStep>
                        <asp:WizardStep runat="server" ID="WizardStep2" Title="Update">
                            <asp:Label ID="LabelEid" runat="server" Text="Employee ID"></asp:Label><asp:TextBox
                                ID="TextBox1" runat="server" Style="margin-left: 36px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label7" runat="server" Text="First Name"></asp:Label><asp:TextBox
                                ID="TextBox2" runat="server" Style="margin-left: 46px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label8" runat="server" Text="Last Name"></asp:Label><asp:TextBox ID="TextBox3"
                                runat="server" Style="margin-left: 54px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label9" runat="server" Text="Position"></asp:Label><asp:TextBox ID="TextBox4"
                                runat="server" Style="margin-left: 67px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label10" runat="server" Text="Email"></asp:Label><asp:TextBox ID="TextBox5"
                                runat="server" Style="margin-left: 82px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label11" runat="server" Text="Phone Number"></asp:Label><asp:TextBox
                                ID="TextBox6" runat="server" Style="margin-left: 32px"></asp:TextBox><br />
                            <br />
                            <asp:Button ID="Button5" runat="server" Text="Update" Height="25px" 
                                OnClick="Button5_Click" style="margin-left: 239px" Width="63px" />
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" ID="WizardStep3" Title="Search">
                            <asp:Label ID="LabelSearchFName" runat="server" Text="First Name"></asp:Label><asp:TextBox
                                ID="TextBoxSearchFname" runat="server" Style="margin-left: 38px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="LabelSearchLName" runat="server" Text="Last name"></asp:Label>&#160;<asp:TextBox
                                ID="TextBoxsearchLName" runat="server" Style="margin-left: 38px"></asp:TextBox><br />
                            <br />
                            <asp:Label ID="LabelSearchPosition" runat="server" Text="Position"></asp:Label>
                            <asp:DropDownList
                                ID="DropDownListSearchPosition" runat="server" DataSourceID="SqlDataSource3"
                                DataTextField="PositionName" DataValueField="PositionID" Height="16px" Style="margin-left: 56px; margin-bottom: 0px;"
                                Width="135px">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>"
                                SelectCommand="SELECT [PositionID], [PositionName] FROM [Position]"></asp:SqlDataSource><br />
                            <asp:Label ID="lblErr" runat="server" Text="Message"></asp:Label><br />
                            <br />
                            <asp:Button ID="Button1" runat="server" Text="Search" Style="margin-left: 94px" OnClick="Button1_Click" /><asp:Button
                                ID="Button2" runat="server" Text="Clear" Style="margin-left: 20px" /></asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EmployeeID"
                    DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="EmployeeID" HeaderText="ID" ReadOnly="True" SortExpression="EmployeeID" />
                        <asp:BoundField DataField="EmployeeFirtName" HeaderText="FirstName" SortExpression="EmployeeFirtName" />
                        <asp:BoundField DataField="EmployeeLastName" HeaderText="LastName" SortExpression="EmployeeLastName" />
                        <asp:TemplateField HeaderText="Position" SortExpression="PositionID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PositionID") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource4"
                                    DataTextField="PositionName" DataValueField="PositionID" SelectedValue='<%# Eval("PositionID") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>"
                                    SelectCommand="SELECT [PositionID], [PositionName] FROM [Position]"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
                    </Columns>
                    <selectedrowstyle backcolor="LightCyan"
         forecolor="DarkBlue"
         font-bold="True"/>  
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>"
                    SelectCommand="SELECT * FROM [Employee]" ConflictDetection="CompareAllValues"
                    DeleteCommand="DELETE FROM [Employee] WHERE [EmployeeID] = @original_EmployeeID AND [EmployeeFirtName] = @original_EmployeeFirtName AND [EmployeeLastName] = @original_EmployeeLastName AND [PositionID] = @original_PositionID AND [Email] = @original_Email AND (([PhoneNumber] = @original_PhoneNumber) OR ([PhoneNumber] IS NULL AND @original_PhoneNumber IS NULL))"
                    InsertCommand="INSERT INTO [Employee] ([EmployeeID], [EmployeeFirtName], [EmployeeLastName], [PositionID], [Email], [PhoneNumber]) VALUES (@EmployeeID, @EmployeeFirtName, @EmployeeLastName, @PositionID, @Email, @PhoneNumber)"
                    OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Employee] SET [EmployeeFirtName] = @EmployeeFirtName, [EmployeeLastName] = @EmployeeLastName, [PositionID] = @PositionID, [Email] = @Email, [PhoneNumber] = @PhoneNumber WHERE [EmployeeID] = @original_EmployeeID AND [EmployeeFirtName] = @original_EmployeeFirtName AND [EmployeeLastName] = @original_EmployeeLastName AND [PositionID] = @original_PositionID AND [Email] = @original_Email AND (([PhoneNumber] = @original_PhoneNumber) OR ([PhoneNumber] IS NULL AND @original_PhoneNumber IS NULL))">
                    <DeleteParameters>
                        <asp:Parameter Name="original_EmployeeID" Type="Int32" />
                        <asp:Parameter Name="original_EmployeeFirtName" Type="String" />
                        <asp:Parameter Name="original_EmployeeLastName" Type="String" />
                        <asp:Parameter Name="original_PositionID" Type="Int32" />
                        <asp:Parameter Name="original_Email" Type="String" />
                        <asp:Parameter Name="original_PhoneNumber" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="EmployeeID" Type="Int32" />
                        <asp:Parameter Name="EmployeeFirtName" Type="String" />
                        <asp:Parameter Name="EmployeeLastName" Type="String" />
                        <asp:Parameter Name="PositionID" Type="Int32" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="EmployeeFirtName" Type="String" />
                        <asp:Parameter Name="EmployeeLastName" Type="String" />
                        <asp:Parameter Name="PositionID" Type="Int32" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                        <asp:Parameter Name="original_EmployeeID" Type="Int32" />
                        <asp:Parameter Name="original_EmployeeFirtName" Type="String" />
                        <asp:Parameter Name="original_EmployeeLastName" Type="String" />
                        <asp:Parameter Name="original_PositionID" Type="Int32" />
                        <asp:Parameter Name="original_Email" Type="String" />
                        <asp:Parameter Name="original_PhoneNumber" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Who`s doing what?">
            <ContentTemplate><p>Check the responsibilities of each Team member.</p>
            <br />
                <asp:Panel ID="Panel1" runat="server" Height="129px">
                    <table>
                        <tr>
                            <td><asp:Label ID="Label12" runat="server" Text="Event Name:"></asp:Label></td>
                            <td><asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label13" runat="server" Text="Employee Last Name:"></asp:Label></td>
                            <td><asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="Button3" runat="server" Text="Search" Height="26px" 
                        style="margin-left: 164px" Width="64px" onclick="Button3_Click" />
                    <asp:Button ID="Button4" runat="server" Text="Clear" Height="26px" 
                        style="margin-left: 20px" onclick="Button4_Click"/>
                </asp:Panel>
                <br />
                                       
                    
                    
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource5" AllowPaging="True" AllowSorting="True">
                        <Columns>
                            <asp:BoundField DataField="EmployeeFirtName" HeaderText="First Name" 
                                SortExpression="EmployeeFirtName" />
                            <asp:BoundField DataField="EmployeeLastName" HeaderText="Last Name" 
                                SortExpression="EmployeeLastName" />
                            <asp:BoundField DataField="Task" HeaderText="Task" SortExpression="Task" />
                            <asp:BoundField DataField="EventName" HeaderText="Event" 
                                SortExpression="EventName" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>" 
                    SelectCommand="SELECT [Task], [EmployeeFirtName], [EventName], [EmployeeLastName] FROM [EmpEvent]">
                </asp:SqlDataSource>
                                       
                    
                    
           
            </ContentTemplate>
        </asp:TabPanel>
    </asp:TabContainer>
</asp:Content>
