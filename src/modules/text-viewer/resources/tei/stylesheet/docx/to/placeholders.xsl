<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teix="http://www.tei-c.org/ns/Examples" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:tbx="http://www.lisa.org/TBX-Specification.33.0.html" xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:contypes="http://schemas.openxmlformats.org/package/2006/content-types" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:iso="http://www.iso.org/ns/1.0" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:cals="http://www.oasis-open.org/specs/tm9901" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" exclude-result-prefixes="cp ve o r m v wp w10 w wne mml tbx iso      tei a xs pic fn xsi dc dcterms dcmitype     contypes teidocx teix html cals"><xsl:import href="../../common2/header.xsl"/><xsl:import href="../../common2/i18n.xsl"/><doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet"><desc><p> TEI stylesheet for making Word docx files from TEI XML </p><p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p><p>Author: See AUTHORS</p><p>Id: $Id: placeholders.xsl 9669 2011-11-07 19:17:54Z rahtz $</p><p>Copyright: 2008, TEI Consortium</p></desc></doc><doc xmlns="http://www.oxygenxml.com/ns/doc/xsl"><desc>
        A callback for any titlepages that belong to the front matter.
    </desc></doc><xsl:template name="titlepages"/><doc xmlns="http://www.oxygenxml.com/ns/doc/xsl"><desc>
	Title of document        
    </desc></doc><xsl:template name="document-title"><xsl:choose><xsl:when test="/tei:TEI/tei:text/tei:front/tei:titlePage"/><xsl:when test="/tei:TEI/tei:text/tei:front/tei:docTitle"/><xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"><xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"><xsl:call-template name="block-element"><xsl:with-param name="style">GeneratedTitle</xsl:with-param></xsl:call-template></xsl:for-each><xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"><xsl:call-template name="block-element"><xsl:with-param name="style">GeneratedSubtitle</xsl:with-param></xsl:call-template></xsl:for-each></xsl:when><xsl:otherwise><xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"><xsl:call-template name="block-element"><xsl:with-param name="style">GeneratedTitle</xsl:with-param></xsl:call-template></xsl:for-each></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="created-by"/><xsl:template name="headerParts"/><doc xmlns="http://www.oxygenxml.com/ns/doc/xsl"><desc>
        
        Template for all simple block elements.
        This template looks for a style definition template (mode="get-style") that
        matches the block element that is currently processed. If none is specified
        it copies the style definition from the parent element.
        
        If some special rendering is required you should overwrite this template.
        
    </desc></doc><xsl:template match="*[not(tei:is-inline(.))]" priority="-10"><xsl:param name="style"/><xsl:param name="pPr"/><xsl:param name="nop"/>
        <!-- calculate style definition --><xsl:variable name="newStyle"><xsl:apply-templates select="." mode="get-style"/></xsl:variable><xsl:variable name="styleToPassOn"><xsl:choose><xsl:when test="string-length($newStyle) &gt; 0"><xsl:value-of select="$newStyle"/></xsl:when><xsl:otherwise><xsl:value-of select="$style"/></xsl:otherwise></xsl:choose></xsl:variable>

        <!-- process children  --><xsl:call-template name="block-element"><xsl:with-param name="style" select="$styleToPassOn"/><xsl:with-param name="pPr" select="$pPr"/><xsl:with-param name="nop" select="$nop"/></xsl:call-template></xsl:template><doc xmlns="http://www.oxygenxml.com/ns/doc/xsl"><desc>
        
            Template for all simple inline elements
            This template looks for a character style definition template (mode="get-style")
            for the currently processed element.
        
    </desc></doc><xsl:template match="*[tei:is-inline(.)]" priority="-10"><xsl:param name="character-style"/><xsl:param name="style"/><xsl:param name="pPr"/><xsl:variable name="style"><xsl:apply-templates select="." mode="get-style"/></xsl:variable><xsl:variable name="iso-style"><xsl:if test=".//tbx:termNote/@iso:style"><xsl:value-of select=".//tbx:termNote/@iso:style"/></xsl:if></xsl:variable><xsl:variable name="use-style"><xsl:choose><xsl:when test="(string-length($style) &gt; 0)"><xsl:value-of select="$style"/></xsl:when><xsl:when test="(string-length($iso-style) &gt; 0)"><xsl:value-of select="$iso-style"/></xsl:when><xsl:otherwise><xsl:value-of select="$character-style"/></xsl:otherwise></xsl:choose></xsl:variable><xsl:apply-templates><xsl:with-param name="character-style" select="$use-style"/></xsl:apply-templates></xsl:template></xsl:stylesheet>