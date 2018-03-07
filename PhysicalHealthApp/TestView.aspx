<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestView.aspx.cs" Inherits="PhysicalHealthApp.TestView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    <asp:Label ID="lblSummaryType" runat="server" Text="View New Result"></asp:Label>
                    <asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary pull-right" Text="Back" OnClick="btnBack_Click" />
                </h1>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="font-weight: bold; font-size: 2em;">
                            <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                        </h3>
                    </div>
                    <div class="panel-body" style="background-color: #2a9fd6; color: azure;">
                        <div class="row">
                            <div class="col-md-8">
                                <h4 class="panel-title">NHS:
                                    <asp:Label ID="lblNHS" runat="server"></asp:Label>
                                </h4>
                                <h4 class="panel-title">Date of Birth: 
                                    <asp:Label ID="lblDoB" runat="server"></asp:Label>
                                </h4>
                                <%--<h4 class="panel-title">Organisation: 
                                    <asp:Label ID="lblOrganisation" runat="server"></asp:Label></h4>--%>
                                <asp:HiddenField ID="hdnPatientID" runat="server" />
                                <asp:HiddenField ID="hdnMatchedclinicianid" runat="server" />
                                <asp:HiddenField ID="hdnUserId" runat="server" />
                                <asp:HiddenField ID="hdnTestId" runat="server" />
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
                                <h3 class="panel-title"><i class="fa fa-edit"></i>&nbsp;Result</h3>
                            </div>
                            <div class="panel-body">

                                <table class="table table-bordered table-striped">
                                    <tr>
                                        <td style="width: 30%">
                                            <strong>Test Type:</strong>
                                        </td>
                                        <td style="width: 70%">
                                            <asp:Label ID="lbltesttypename" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <strong>Result</strong>
                                        </td>
                                        <td style="width: 70%">
                                            <asp:Label ID="lbltestnumericresult" runat="server"></asp:Label>
                                            <asp:Label ID="lblunitstext" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <strong>Reference Range:</strong>
                                        </td>
                                        <td style="width: 70%"><                                           
                                            <asp:Label ID="lbllowerreferencerange" runat="server"></asp:Label>
                                            <asp:Label ID="lblupperreferencerange" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <strong>Message from clinician:</strong>
                                        </td>
                                        <td style="width: 70%">
                                            <asp:Label ID="lblclinicianmessage" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <strong>Next recomended test date:</strong>
                                        </td>
                                        <td style="width: 70%">
                                            <div>
                                                <asp:Label ID="lblnexttestdate" runat="server"></asp:Label>
                                            </div>     
                                        </td>
                                    </tr>
                                </table>



                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>


    </div>

</asp:Content>



