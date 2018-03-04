<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="PhysicalHealthApp.NavBar" %>

<ul class="nav navbar-nav navbar-right navbar-user">   
    <li class="dropdown user-dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>Steve Miller<b class="caret"></b></a>
        <ul class="dropdown-menu">
            <li><a href="#"><i class="fa fa-user"></i>Profile</a></li>
            <li><a href="#"><i class="fa fa-gear"></i>Settings</a></li>
            <li class="divider"></li>
            <li><a href="logout.aspx"><i class="fa fa-power-off"></i>&nbsp;Log Out</a></li>

        </ul>
    </li>
    <li class="divider-vertical"></li>
</ul>
