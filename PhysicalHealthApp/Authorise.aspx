<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Authorise.aspx.cs" Inherits="PhysicalHealthApp.Authorise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div style="font-size: 2.4em; margin-top: 10px; border-bottom: 10px; color: white;">
                    <asp:Label ID="lblSummaryType" runat="server" Text="Authorisation Request"></asp:Label>
                    <asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary pull-right" Text="Back" OnClick="btnBack_Click" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="font-weight: bold; font-size: 2em;">
                            <asp:Label ID="lblUserFullName" runat="server"></asp:Label>
                        </h3>
                    </div>
                    <div class="panel-body" style="background-color: #2a9fd6; color: azure;">
                        <div class="row">
                            <div class="col-md-8">
                                <h3 class="panel-title">User Type:
                                    <asp:Label ID="lblUserType" runat="server"></asp:Label>
                                </h3>
                                <h4 class="panel-title"><asp:Label ID="lblUniqueIDName" runat="server"></asp:Label>:
                                    <asp:Label ID="lblUniqueID" runat="server"></asp:Label>
                                </h4>                                
                                <h4 id="h4DoB" runat="server" class="panel-title">Date of Birth: 
                                    <asp:Label ID="lblDoB" runat="server"></asp:Label>
                                </h4>
                                <%--<h4 class="panel-title">Organisation: 
                                    <asp:Label ID="lblOrganisation" runat="server"></asp:Label></h4>--%>
                                <asp:HiddenField ID="hdnSelectedUserID" runat="server" />
                                <asp:HiddenField ID="hdnMatchedclinicianid" runat="server" />
                                <asp:HiddenField ID="hdnUserId" runat="server" />
                            </div>
                            <div class="col-md-4">
                                <asp:Panel ID="pnlCurrentStatus" runat="server">
                                    <asp:Label ID="lblCurrentStatus" runat="server"></asp:Label>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnAuthorise" runat="server" CssClass="btn btn-block btn-lg btn-success" Text="Authorise Request" onclick="btnAuthorise_Click"/>
                    </div>
                </div>

                <br />

                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnReject" runat="server" CssClass="btn btn-block btn-lg btn-danger" Text="Reject Request" OnClick="btnReject_Click" />
                    </div>
                </div>

                <asp:HiddenField ID="hdnEmail" runat="server" />
            </div>
        </div>


    </div>

</asp:Content>




