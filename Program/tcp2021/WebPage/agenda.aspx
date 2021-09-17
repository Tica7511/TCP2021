<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="agenda.aspx.cs" Inherits="WebPage_agenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container margin15T">
        <div id="Insidemaincontent">
            <!-- 所有網站內容放在此以下 -->
            <!--<span class="font-normal"><a id="MainContent" href="#MainContent" title="內容" accesskey="C" tabindex="">:::</a></span>-->

            <div class="filetitlewrapper">
                <span class="filetitle font-size5">Workshop Agenda</span>
                <!--<span class="itemright">麵包屑</span>-->
            </div>

            <div class="margin10T textright">
                <a href="<%= ResolveUrl("~/doc/Workshop Agenda_0721.pdf") %>" target="_blank" class="genbtn">Short Agenda</a>
                <a href="<%= ResolveUrl("~/doc/Workshop Agenda_full_0706.2.pdf") %>" target="_blank" class="genbtn">Full Agenda</a>
            </div>

            <div class="margin10T stripeMeCS">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <th>August 28 to September 11</th>
                    </tr>
                    <tr>
                        <td valign="top">Online Course 1
                             <ul>
                                 <li>Opening Remarks </li>
                                 <li>Roadmap and Core Curriculum of Medical Device PWA</li>
                                 <li>CoE Training Program</li>
                             </ul>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">Online Course 2
                             <ul>
                                 <li>Definition of the Terms &lsquo;Medical Device&rsquo; and &lsquo;In Vitro    Diagnostic (IVD) Medical Device&rsquo; (GHTF/SG1/N071:2012)</li>
                                 <li>Basic Scheme of Conformity Assessment Procedure and    Classification for Medical Devices (GHTF/SG1/N77&amp;N78)</li>
                                 <li>Summary of Essential Principles for Medical Devices (IMDRF/GRRP    WG/N47)</li>
                                 <li>Introduction of Case Study: MD Session</li>
                             </ul>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">Online Course 3
                             <ul>
                                 <li>Definition of the Terms &lsquo;Medical Device&rsquo; and &lsquo;In Vitro    Diagnostic (IVD) Medical Device&rsquo; (GHTF/SG1/N071:2012)</li>
                                 <li>Basic Scheme of Conformity Assessment Procedure and Classification    for In Vitro Diagnostic (IVD) Medical Devices (GHTF/SG1/N045&amp;N046)</li>
                                 <li>Summary of Essential Principles for In Vitro Diagnostic (IVD)    Medical Devices (IMDRF/GRRP WG/N47)</li>
                                 <li>Introduction of Case Study: IVD Session</li>
                             </ul>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">Online Course 4
                             <ul>
                                 <li>Introduction of Clinical Evaluation (IMDRF/MDCE WG/N55&amp;N56&amp;N57    FINAL:2019)</li>
                             </ul>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">Online Course 5
                            <br>
                            <ul>
                                <li>Current harmonization status of pre-market regulation in APEC    member economies</li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- stripeMeCS -->

            <div class="stripeMeCSl margin10T">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th>item</th>
                        <th nowrap>Time length</th>
                        <th>Topic</th>
                        <th>Speaker</th>
                    </tr>
                    <tr class="spe">
                        <td colspan="4" class="font-bold">Introduction Session (Online Course)</td>
                    </tr>
                    <tbody>
                        <tr>
                            <td rowspan="4" align="center">1</td>
                            <td align="center">N/A</td>
                            <td valign="middle">Introductory Remarks</td>
                            <td valign="top">Dr. Shih-Chung Chen<br>
                                Minister, Ministry of Health and Welfare (MOHW)
                            </td>
                        </tr>
                        <tr>
                            <td align="center">5 minutes</td>
                            <td valign="middle">Opening Remarks</td>
                            <td valign="top">Dr. Shou-Mei Wu<br>
                                Director General, Taiwan Food and Drug Administration (TFDA), MOHW
                            </td>
                        </tr>
                        <tr>
                            <td align="center">10 minutes</td>
                            <td valign="middle">Roadmap and Core Curriculum of Medical Device PWA</td>
                            <td valign="top">APEC LSIF RHSC MD PWA Co-Champion:<br>
                                Mr. Yuda Maeda<br>
                                Coordinator, Office of International Cooperation, Pharmaceuticals    and Medical Devices Agency (PMDA), Japan</td>
                        </tr>
                        <tr>
                            <td align="center">10 minutes</td>
                            <td valign="middle">CoE Training Program</td>
                            <td valign="top">Ms. Cheng-Ning Wu,<br>
                                Senior Technical Specialist, Division of Medical Devices and Cosmetics, TFDA, MOHW
                            </td>
                        </tr>
                    </tbody>
                    <tr class="spe">
                        <td colspan="4" class="font-bold">Medical Device Session (Online Course)</td>
                    </tr>

                    <tr>
                        <td align="center">2</td>
                        <td align="center">40 minutes</td>
                        <td valign="top">
                            <ul>
                                <li>Definition of the Terms &lsquo;Medical Device&rsquo; and    &lsquo;In Vitro Diagnostic (IVD) Medical Device&rsquo; (GHTF/SG1/N071:2012)</li>
                                <li>Basic Scheme of Conformity Assessment    Procedure and Classification for Medical Devices (GHTF/SG1/N77&amp;N78)</li>
                                <li>Summary of Essential Principles for Medical    Devices (IMDRF/GRRP WG/N47)</li>
                                <li>Introduction of Case Study: MD Session</li>
                            </ul>
                            Product: Soft Contact Lens</td>
                        <td valign="top">Dr. Jai-Yen Chen
                            <br>
                            Senior Reviewer,<br>
                            Division of Medical Devices,<br>
                            Center for Drug Evaluation (CDE)</td>
                    </tr>

                    <tr class="spe">
                        <td colspan="4" class="font-bold">In Vitro Diagnostic Medical Device Session (Online Course)</td>
                    </tr>
                    <tbody>
                        <tr>
                            <td align="center">3</td>
                            <td align="center">40 minutes </td>
                            <td valign="top">
                                <ul>
                                    <li>Definition of the Terms &lsquo;Medical Device&rsquo; and    &lsquo;In Vitro Diagnostic (IVD) Medical Device&rsquo; (GHTF/SG1/N071:2012)</li>
                                    <li>Basic Scheme of Conformity Assessment    Procedure and Classification for Medical Devices (GHTF/SG1/N77&amp;N78)</li>
                                    <li>Summary of Essential Principles for Medical    Devices (IMDRF/GRRP WG/N47)</li>
                                    <li>Introduction of Case Study: IVD Session</li>
                                </ul>
                                Product:    Pregnancy Rapid Test</td>
                            <td valign="top">Dr. Te-Hsuen Chen<br>
                                Senior Reviewer,<br>
                                Division of Medical Devices and Cosmetics,<br>
                                TFDA, MOHW</td>
                        </tr>
                    </tbody>
                    <tr class="spe">
                        <td colspan="4" class="font-bold">Clinical Evaluation Session (Online Course)</td>
                    </tr>
                    <tr>
                        <td align="center">4</td>
                        <td align="center">40 minutes</td>
                        <td valign="top">
                            <ul>
                                <li>Clinical Investigation (IMDRF/MDCE WG/N57FINAL:2019)</li>
                                <li>Clinical Evaluation (IMDRF/MDCE    WG/N56FINAL:2019)</li>
                                <li>Clinical Evidence (IMDRF/MDCE    WG/N55FINAL:2019)</li>
                            </ul>
                        </td>
                        <td valign="top">Dr. Mami Ho
                            <br>
                            Senior Scientist for Clinical Medicine,<br>
                            Medical Device Unit, Office of Medical Devices I, PMDA, Japan</td>
                    </tr>

                    <tr class="spe">
                        <td colspan="4" class="font-bold">Current harmonization status of pre-market regulation in APEC    member economies (Online Course)</td>
                    </tr>
                    <tbody>
                        <tr>
                            <td align="center">5</td>
                            <td align="center" nowrap>10 minutes/each</td>
                            <td valign="top">The sharing of current harmonization status of pre-market    regulation in APEC member economies will be pre-recorded. Regulators who    participate in the workshop will be invited to pre-record their presentation.</td>
                            <td valign="top">Representatives from regulatory authorities of each    participating member economy </td>
                        </tr>
                    </tbody>

                    <!--<tr class="spe">
                         <td colspan="4" class="font-bold">Digital Health (Optional Online Course)</td>
                     </tr>
                     <tr>
                         <td  align="center">6</td>
                         <td  align="center">40 minutes </td>
                         <td  valign="middle">Cybersecurity Case Sharing of Korea</td>
                         <td  valign="top">Ms. Eun-Hee Cho<br>
                             RA Director,<br>
                             Abbott Medical Devices, Korea</td>
                     </tr>-->
                </table>
            </div>
            <!-- stripeMe -->

            <!-- 所有網站內容放在此以上 -->
        </div>
        <!-- Insidemaincontent -->
    </div>
    <!-- conainer -->
</asp:Content>