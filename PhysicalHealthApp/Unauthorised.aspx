<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Unauthorised.aspx.cs" Inherits="PhysicalHealthApp.Unauthorised" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">

        <div class="row" style="margin-top: 40px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 login-container">

                <div class="login-form">
                    <div>

                        
                        <div class="alert alert-danger">

                            <h3>Unauthorised</h3>

                            You have tried to access a resource that you do not have access to.

                        </div>

                       
                    </div>
                </div>

            </div>

            <div class="col-md-4"></div>


        </div>


        <div class="row" style="margin-top: 15px;">
            <div class="col-md-4"></div>

            <div class="col-md-4">
                <div class="login-form">
                    <div>
                        <a class="btn btn-default" href="Default.aspx">Return Home</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>
        </div>




    </div>
</asp:Content>
