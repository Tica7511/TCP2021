<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="training.aspx.cs" Inherits="WebPage_training" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container margin15T">
    <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <div class="filetitlewrapper">
           <span class="filetitle font-size5">Online Training</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>
       <div class="font-size3 font-title margin10T">Guidances</div>
       <ol class="doclist">
           <li><a href="<%= ResolveUrl("~/doc/1_ghtf-sg1-n071-2012-definition-of-terms-120516.pdf") %>" target="_blank">Definition of the Terms ‘Medical Device’ and ‘In Vitro Diagnostic (IVD) Medical Device’</a></li>
           <li><a href="<%= ResolveUrl("~/doc/2_ghtf-sg1-n77-2012-principles-medical-devices-classification-121102.pdf") %>" target="_blank">Principles of Medical Devices Classification</a></li>
           <li><a href="<%= ResolveUrl("~/doc/3_ghtf-sg1-n045-2008-principles-ivd-medical-devices-classification-080219.pdf") %>" target="_blank">Principles of IVD Medical Devices Classification</a></li>
           <li><a href="<%= ResolveUrl("~/doc/4_ghtf-sg1-n78-2012-conformity-assessment-medical-devices-121102.pdf") %>" target="_blank">Principles of Conformity Assessment for Medical Devices</a></li>
           <li><a href="<%= ResolveUrl("~/doc/5_ghtf-sg1-n046-2008-principles-of-ca-for-ivd-medical-devices-080731.pdf") %>" target="_blank">Principles of Conformity Assessment for In Vitro Diagnostic (IVD) Medical Devices</a></li>
           <li><a href="<%= ResolveUrl("~/doc/6_imdrf-tech-181031-grrp-essential-principles-n47.pdf") %>" target="_blank">Essential Principles of Safety and Performance of Medical Devices and IVD Medical Devices</a></li>
           <li><a href="<%= ResolveUrl("~/doc/7_imdrf-tech-191010-mdce-n55.pdf") %>" target="_blank">Clinical Evidence - Key Definitions and Concepts</a></li>
           <li><a href="<%= ResolveUrl("~/doc/8_imdrf-tech-191010-mdce-n56.pdf") %>" target="_blank">Clinical Evaluation</a></li>
           <li><a href="<%= ResolveUrl("~/doc/9_imdrf-tech-191010-mdce-n57.pdf") %>" target="_blank">Clinical Investigation</a></li>
       </ol>

       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
    </div>
</asp:Content>

