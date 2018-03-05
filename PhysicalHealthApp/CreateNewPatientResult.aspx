<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewPatientResult.aspx.cs" Inherits="PhysicalHealthApp.CreateNewPatientResult" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    <asp:Label ID="lblSummaryType" runat="server" Text="Record New Result"></asp:Label><asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary pull-right" Text="Back" OnClick="btnBack_Click"/></h1>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="font-weight: bold; font-size: 2em;">
                            <asp:Label ID="lblPatientName" runat="server"></asp:Label></h3>
                    </div>
                    <div class="panel-body" style="background-color: #2a9fd6; color: azure;">
                        <div class="row">
                            <div class="col-md-8">
                                <h4 class="panel-title">NHS:
                                    <asp:Label ID="lblNHS" runat="server"></asp:Label></h4>
                                <h4 class="panel-title">Date of Birth: 
                                    <asp:Label ID="lblDoB" runat="server"></asp:Label></h4>
                                <%--<h4 class="panel-title">Organisation: 
                                    <asp:Label ID="lblOrganisation" runat="server"></asp:Label></h4>--%>
                                <asp:HiddenField ID="hdnPatientID" runat="server" />
                                <asp:HiddenField ID="hdnMatchedclinicianid" runat="server" />
                            </div>
                            <div class="col-md-4">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-edit"></i>&nbsp;Enter new record</h3>
                    </div>
                    <div class="panel-body">
                        
                        <div style="text-align: center;">                            
                            <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>
                        </div>

                        <asp:Panel ID="fgMatchedOrganisation" runat="server" class="form-group">
                            <asp:Label ID="lblTestTypeID" runat="server" CssClass="control-label" for="ddlTestTypeID" Text="Select a test from the list below" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errTestTypeID" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlTestTypeID" runat="server" CssClass="form-control input-lg">
                            </asp:DropDownList>
                        </asp:Panel>




                    </div>
                </div>
            </div>
        </div>


            </div>
        </div>


    </div>

</asp:Content>



