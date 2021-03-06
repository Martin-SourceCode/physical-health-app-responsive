﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClinicianSummary.aspx.cs" Inherits="PhysicalHealthApp.ClinicianSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    <asp:Label ID="lblSummaryType" runat="server" Text="My Summary"></asp:Label></h1>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="font-weight: bold; font-size: 2em;">
                            <asp:Label ID="lblClinianName" runat="server"></asp:Label></h3>
                    </div>
                    <div class="panel-body" style="background-color: #2a9fd6; color: azure;">
                        <div class="row">
                            <div class="col-md-8">

                                <h4 class="panel-title">GMC Number:
                                    <asp:Label ID="lblGMC" runat="server"></asp:Label></h4>
                                <h4 class="panel-title">Organisation: 
                                    <asp:Label ID="lblOrganisation" runat="server"></asp:Label></h4>
                                <asp:HiddenField ID="hdnClinicianID" runat="server" />
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
                        <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i>&nbsp;New Patient Requests (<asp:Label ID="lblNewRequestCount" runat="server"></asp:Label>)</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DataGrid ID="dgMyUnauthorisedPatients" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" ShowHeader="false">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Patient">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <a href='<%# DataBinder.Eval(Container, "DataItem.userid", "Authorise.aspx?id={0}") %>'>
                                                    <div>
                                                        <span style="font-size: 1.8em;">
                                                            <asp:Label ID="lblFullName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.firstname") %>'></asp:Label>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.lastname") %>'></asp:Label>
                                                        </span>
                                                        <br />
                                                        NHS Number:
                                                        <asp:Label ID="lblNHSNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.nhsnumber") %>'></asp:Label>
                                                        <br />
                                                        Date of Birth:
                                                        <asp:Label ID="lblDoB" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dateofbirth", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                    </div>
                                                </a>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>

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
                        <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i>&nbsp;All my patients (<asp:Label ID="lblAllPatientCount" runat="server"></asp:Label>)</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DataGrid ID="dgMyPatients" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" ShowHeader="false">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Patient">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <a href='<%# DataBinder.Eval(Container, "DataItem.userid", "PatientSummary.aspx?id={0}") %>'>
                                                    <div>
                                                        <span style="font-size: 1.8em;">
                                                            <asp:Label ID="lblFullName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.firstname") %>'></asp:Label>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.lastname") %>'></asp:Label>
                                                        </span>
                                                        <br />
                                                        NHS Number:
                                                        <asp:Label ID="lblNHSNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.nhsnumber") %>'></asp:Label>
                                                        <br />
                                                        Date of Birth:
                                                        <asp:Label ID="lblDoB" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dateofbirth", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                    </div>
                                                </a>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>

                                    </Columns>



                                </asp:DataGrid>
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
                        <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i>&nbsp;My Rejected Requests (<asp:Label ID="lbRejectedRequestCount" runat="server"></asp:Label>)</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DataGrid ID="dgMyRejectedRequests" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" ShowHeader="false">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Patient">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <a href='<%# DataBinder.Eval(Container, "DataItem.userid", "Authorise.aspx?id={0}") %>'>
                                                    <div>
                                                        <span style="font-size: 1.8em;">
                                                            <asp:Label ID="lblFullName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.firstname") %>'></asp:Label>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.lastname") %>'></asp:Label>
                                                        </span>
                                                        <br />
                                                        NHS Number:
                                                        <asp:Label ID="lblNHSNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.nhsnumber") %>'></asp:Label>
                                                        <br />
                                                        Date of Birth:
                                                        <asp:Label ID="lblDoB" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dateofbirth", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                                    </div>
                                                </a>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>

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



