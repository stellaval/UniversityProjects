<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Theme="Skin1" CodeBehind="Event.aspx.cs" Inherits="WebAppEventManagement.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Events</h2>
    <asp:Panel ID="Panel1" runat="server">
        <asp:Label ID="LabelEvID" runat="server" Text="EventID:"></asp:Label>
        <asp:TextBox ID="TextBoxEvID" runat="server" style="margin-left: 45px"></asp:TextBox>
        <br />
        <asp:Label ID="LabelEvName" runat="server" Text="Event Name:"></asp:Label>
        <asp:TextBox ID="TextBoxEvName" runat="server" style="margin-left: 19px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" 
            style="margin-left: 91px" onclick="ButtonSearch_Click" />
        <asp:Button ID="ButtonClear" runat="server" Text="Clear" 
            style="margin-left: 21px" onclick="ButtonClear_Click" />
        <br />
    </asp:Panel>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="EventID" 
        DataSourceID="SqlDataSource1">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" />
            <asp:BoundField DataField="EventID" HeaderText="EventID" ReadOnly="True" 
                SortExpression="EventID" />
            <asp:BoundField DataField="EventName" HeaderText="EventName" 
                SortExpression="EventName" />
            <asp:BoundField DataField="Place" HeaderText="Place" SortExpression="Place" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
            <asp:BoundField DataField="Description" HeaderText="Description" 
                SortExpression="Description" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConflictDetection="CompareAllValues" 
    ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>" 
    DeleteCommand="DELETE FROM [Event] WHERE [EventID] = @original_EventID AND [EventName] = @original_EventName AND [Place] = @original_Place AND [Date] = @original_Date AND [Time] = @original_Time AND (([Description] = @original_Description) OR ([Description] IS NULL AND @original_Description IS NULL))" 
    InsertCommand="INSERT INTO [Event] ([EventID], [EventName], [Place], [Date], [Time], [Description]) VALUES (@EventID, @EventName, @Place, @Date, @Time, @Description)" 
    OldValuesParameterFormatString="original_{0}" 
    SelectCommand="SELECT * FROM [Event]" 
    UpdateCommand="UPDATE [Event] SET [EventName] = @EventName, [Place] = @Place, [Date] = @Date, [Time] = @Time, [Description] = @Description WHERE [EventID] = @original_EventID AND [EventName] = @original_EventName AND [Place] = @original_Place AND [Date] = @original_Date AND [Time] = @original_Time AND (([Description] = @original_Description) OR ([Description] IS NULL AND @original_Description IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_EventID" Type="Int32" />
            <asp:Parameter Name="original_EventName" Type="String" />
            <asp:Parameter Name="original_Place" Type="String" />
            <asp:Parameter DbType="Date" Name="original_Date" />
            <asp:Parameter DbType="Time" Name="original_Time" />
            <asp:Parameter Name="original_Description" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EventID" Type="Int32" />
            <asp:Parameter Name="EventName" Type="String" />
            <asp:Parameter Name="Place" Type="String" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="Time" />
            <asp:Parameter Name="Description" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EventName" Type="String" />
            <asp:Parameter Name="Place" Type="String" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="Time" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="original_EventID" Type="Int32" />
            <asp:Parameter Name="original_EventName" Type="String" />
            <asp:Parameter Name="original_Place" Type="String" />
            <asp:Parameter DbType="Date" Name="original_Date" />
            <asp:Parameter DbType="Time" Name="original_Time" />
            <asp:Parameter Name="original_Description" Type="String" />
        </UpdateParameters>
</asp:SqlDataSource>
    <asp:Label ID="lblErr" runat="server" Text="Err"></asp:Label>
    <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
        AutoGenerateRows="False" DataKeyNames="EventID" DataSourceID="SqlDataSource2" 
        DefaultMode="Insert" Height="50px" Width="219px" 
        oniteminserted="DetailsView1_ItemInserted">
        <Fields>
            <asp:BoundField DataField="EventID" HeaderText="EventID" ReadOnly="True" 
                SortExpression="EventID" />
            <asp:BoundField DataField="EventName" HeaderText="EventName" 
                SortExpression="EventName" />
            <asp:BoundField DataField="Place" HeaderText="Place" SortExpression="Place" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
            <asp:BoundField DataField="Description" HeaderText="Description" 
                SortExpression="Description" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>" 
        DeleteCommand="DELETE FROM [Event] WHERE [EventID] = @EventID" 
        InsertCommand="INSERT INTO [Event] ([EventID], [EventName], [Place], [Date], [Time], [Description]) VALUES (@EventID, @EventName, @Place, @Date, @Time, @Description)" 
        SelectCommand="SELECT * FROM [Event]" 
        UpdateCommand="UPDATE [Event] SET [EventName] = @EventName, [Place] = @Place, [Date] = @Date, [Time] = @Time, [Description] = @Description WHERE [EventID] = @EventID">
        <DeleteParameters>
            <asp:Parameter Name="EventID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EventID" Type="Int32" />
            <asp:Parameter Name="EventName" Type="String" />
            <asp:Parameter Name="Place" Type="String" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="Time" />
            <asp:Parameter Name="Description" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EventName" Type="String" />
            <asp:Parameter Name="Place" Type="String" />
            <asp:Parameter DbType="Date" Name="Date" />
            <asp:Parameter DbType="Time" Name="Time" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="EventID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
