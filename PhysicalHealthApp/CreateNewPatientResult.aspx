<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewPatientResult.aspx.cs" Inherits="PhysicalHealthApp.CreateNewPatientResult" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    <asp:Label ID="lblSummaryType" runat="server" Text="Record New Result"></asp:Label>
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
                                <h3 class="panel-title"><i class="fa fa-edit"></i>&nbsp;Record new result</h3>
                            </div>
                            <div class="panel-body">

                                <div style="text-align: center;">
                                    <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>
                                </div>

                                <asp:Panel ID="fgtesttypeid" runat="server" class="form-group">
                                    <asp:Label ID="lbltesttypeid" runat="server" CssClass="control-label" for="ddltesttypeid" Text="Select a test from the list below" Font-Bold="true"></asp:Label>
                                    <asp:Label ID="errtesttypeid" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddltesttypeid" runat="server" CssClass="form-control input-lg" AutoPostBack="true" OnSelectedIndexChanged="ddltesttypeid_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </asp:Panel>

                                <asp:Panel ID="fgtestnumericresult" runat="server" class="form-group">
                                    <label class="control-label" for="txttestnumericresult">Result Value</label>
                                    <asp:Label ID="errtestnumericresult" runat="server"></asp:Label>
                                    <asp:TextBox ID="txttestnumericresult" runat="server" placeholder="0.0" CssClass="form-control input-lg" TextMode="Number"></asp:TextBox>
                                </asp:Panel>

                                <asp:Panel ID="fglowerreferencerange" runat="server" class="form-group">
                                    <label class="control-label" for="txtlowerreferencerange">Lower Reference Range</label>
                                    <asp:Label ID="errlowerreferencerange" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtlowerreferencerange" runat="server" placeholder="0.0" CssClass="form-control input-lg" TextMode="Number"></asp:TextBox>
                                </asp:Panel>

                                <asp:Panel ID="fgupperreferencerange" runat="server" class="form-group">
                                    <label class="control-label" for="txtupperreferencerange">Upper Reference Range</label>
                                    <asp:Label ID="lblupperreferencerange" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtupperreferencerange" runat="server" placeholder="0.0" CssClass="form-control input-lg" TextMode="Number"></asp:TextBox>
                                </asp:Panel>

                                <asp:Panel ID="fgunitstext" runat="server" class="form-group">
                                    <label class="control-label" for="txtunitstext">Units</label>
                                    <asp:Label ID="errunitstext" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtunitstext" runat="server" placeholder="Units" CssClass="form-control input-lg"></asp:TextBox>
                                </asp:Panel>

                                <asp:Panel ID="fgtesttextualresult" runat="server" class="form-group">
                                    <label class="control-label" for="txttesttextualresult">Result Description</label>
                                    <asp:Label ID="errtesttextualresult" runat="server"></asp:Label>
                                    <asp:TextBox ID="txttesttextualresult" runat="server" placeholder="Description" CssClass="form-control input-lg"></asp:TextBox>
                                </asp:Panel>

                                <asp:Panel ID="fgclinicianmessage" runat="server" class="form-group">
                                    <label class="control-label" for="txtclinicianmessage">Message to patient</label>
                                    <asp:Label ID="errclinicianmessage" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtclinicianmessage" runat="server" placeholder="Message" CssClass="form-control input-lg" TextMode="MultiLine" Rows="7" MaxLength="1000"></asp:TextBox>
                                </asp:Panel>


                                <asp:Panel ID="fgnexttestdate" runat="server" class="form-group">
                                    <label class="control-label" for="txtnexttestdate">Next Test Date</label>
                                    <asp:Label ID="errnexttestdate" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtnexttestdate" runat="server" CssClass="form-control input-lg" TextMode="Date"></asp:TextBox>
                                </asp:Panel>


                                <asp:Panel ID="fgclinicianhasapproved" runat="server" class="form-group">
                                    <label class="control-label" for="chkclinicianhasapproved" style="font-size: 2em;">
                                        Confirmation                                                               
                                    </label>
                                    <br />
                                    <asp:Label ID="lblclinicianhasapproved" runat="server"></asp:Label>
                                    <asp:CheckBox ID="chkclinicianhasapproved" runat="server" />
                                    I confirm that I have discussed this result with the patient in a face to face consultation prior to sharing the results with them via application
                                </asp:Panel>

                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Save Test" OnClick="btnSave_Click" />

                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>


    </div>

</asp:Content>



