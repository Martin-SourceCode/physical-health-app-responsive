<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PatientSummary.aspx.cs" Inherits="PhysicalHealthApp.PatientSummary" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    <asp:Label ID="lblSummaryType" runat="server" Text="My Summary"></asp:Label><asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary pull-right" Text="Back" OnClick="btnBack_Click" /></h1>
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
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i>&nbsp;New Test Results</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="btnCreateNewTest" runat="server" CssClass="btn btn-primary pull-right" Text="Record New Result" OnClick="btnCreateNewTest_Click" />
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DataGrid ID="dgMyNewResults" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False">

                                    <Columns>
                                        <asp:BoundColumn DataField="_createddate" DataFormatString="{0:D}" HeaderText="Date">
                                            <HeaderStyle Width="20%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="testtypename" HeaderText="Result">
                                            <HeaderStyle Width="70%" />
                                        </asp:BoundColumn>
                                        <asp:HyperLinkColumn DataNavigateUrlField="testid" DataNavigateUrlFormatString="TestView.aspx?id={0}" Text="View">
                                            <HeaderStyle Width="10%" />
                                        </asp:HyperLinkColumn>
                                    </Columns>



                                </asp:DataGrid>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i>&nbsp;Trending and Results</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Panel ID="fgtesttypeid" runat="server" class="form-group">
                                    <asp:Label ID="lbltesttypeid" runat="server" CssClass="control-label" for="ddltesttypeid" Text="Select a test from the list below" Font-Bold="true"></asp:Label>
                                    <asp:Label ID="errtesttypeid" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddltesttypeid" runat="server" CssClass="form-control input-lg" AutoPostBack="true" OnSelectedIndexChanged="ddltesttypeid_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </asp:Panel>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span style="font-size: 1.8em;">
                                    <asp:Label ID="lblTestType" runat="server"></asp:Label>
                                    Results (<asp:Label ID="lblResultCount" runat="server"></asp:Label>)</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" style="text-align: center;">
                                <asp:Chart ID="Chart1" runat="server" BackColor="64, 64, 64" Width="350px">
                                <Series>
                                    <asp:Series Name="Series1"></asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1" BackColor="#333333"></asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                            </div>                            
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DataGrid ID="dgAllMyResults" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False">

                                    <Columns>
                                        <asp:BoundColumn DataField="_createddate" DataFormatString="{0:D}" HeaderText="Date">
                                            <HeaderStyle Width="20%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="testnumericresult" HeaderText="Result">
                                            <HeaderStyle Width="35%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="unitstext" HeaderText="Units">
                                            <HeaderStyle Width="35%" />
                                        </asp:BoundColumn>
                                        <asp:HyperLinkColumn DataNavigateUrlField="testid" DataNavigateUrlFormatString="TestView.aspx?id={0}" Text="View">
                                            <HeaderStyle Width="10%" />
                                        </asp:HyperLinkColumn>
                                    </Columns>



                                </asp:DataGrid>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>



