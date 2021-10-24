/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lu.fisch.structorizer.generators;

import lu.fisch.structorizer.elements.*;
import lu.fisch.utils.StringList;

/**
 *
 * @author nigjo
 */
public class StructViewerGenerator extends Generator
{
  public StructViewerGenerator()
  {
  }

  @Override
  protected String getDialogTitle()
  {
    return "Export StructViewer AST";
  }

  @Override
  protected String getFileDescription()
  {
    return "StructViewer Pseudo Code (*.svpc)";
  }

  @Override
  protected String[] getFileExtensions()
  {
    return new String[]
    {
      "svpc"
    };
  }

  @Override
  protected String getIndent()
  {
    return " ";
  }

  @Override
  protected String commentSymbolLeft()
  {
    return "#";
  }

  @Override
  protected String getInputReplacer(boolean withPrompt)
  {
    if(withPrompt)
    {
      return "Print $1\nQuery Input $2";
    }
    else
    {
      return "Query Input $1";
    }
  }

  @Override
  protected String getOutputReplacer()
  {
    return "Print $1";
  }

  @Override
  protected boolean breakMatchesCase()
  {
    return false;
  }

  @Override
  protected String getIncludePattern()
  {
    return "Use %";
  }

  @Override
  protected OverloadingLevel getOverloadingLevel()
  {
    return OverloadingLevel.OL_NO_OVERLOADING;
  }

  @Override
  protected TryCatchSupportLevel getTryCatchLevel()
  {
    return TryCatchSupportLevel.TC_NO_TRY;
  }

  @Override
  protected int insertComment(Element _element, String _indent, int _atLine)
  {
    code.add(_element.getComment().concatenate("\n"));
    return 20;
  }

  @Override
  protected String generatePreamble(Root _root, String _indent, StringList _varNames)
  {
    return "";
  }

  @Override
  protected void generateCode(Instruction _inst, String _indent)
  {
    StringList text = _inst.getText();
    for(String line : text.toArray())
    {
      code.add(_indent + line);
    }
  }

  @Override
  protected void generateCode(Alternative _alt, String _indent)
  {
    code.add(_indent + "IF:" + _alt.getText().getText());
    generateCode(_alt.qTrue, _indent + this.getIndent());
    int elseCount = _alt.qFalse.getSize();
    if(elseCount > 0)
    {
      code.add(_indent + "ELSE:");
      generateCode(_alt.qFalse, _indent + this.getIndent());
    }
    code.add(_indent + "ENDIF:");
  }

  @Override
  protected void generateCode(Call _call, String _indent)
  {
    code.add(_indent + "CALL:" + _call.getText().getText());
  }

  @Override
  protected void generateCode(Jump _jump, String _indent)
  {
    code.add(_indent + "BREAK:" + _jump.getText().getText());
  }

  @Override
  protected void generateCode(For _for, String _indent)
  {
    code.add(_indent + "FOR:" + _for.getText().getText());
    super.generateCode(_for, _indent); //To change body of generated methods, choose Tools | Templates.
    code.add(_indent + "ENDFOR:");
  }

  @Override
  protected void generateFooter(Root _root, String _indent)
  {
    super.generateFooter(_root, _indent); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  protected String generateHeader(Root _root, String _indent, String _procName,
      StringList _paramNames, StringList _paramTypes, String _resultType, boolean _public)
  {
    if(_procName != null && !_procName.isEmpty())
    {
      code.add(_indent + "CAPTION:" + _procName);
    }
    return super.generateHeader(_root, _indent, _procName, _paramNames, _paramTypes,
        _resultType, _public); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  protected void generateCode(Parallel _para, String _indent)
  {
    code.add(_indent + "CONCURRENT:");
    for(int i = 0; i < _para.qs.size(); i++)
    {
      code.add(_indent + "THREAD:");
      generateCode((Subqueue)_para.qs.get(i), _indent + this.getIndent());
    }
    code.add(_indent + "ENDCONCURRENT:");
  }

  @Override
  protected void generateCode(Forever _forever, String _indent)
  {
    code.add(_indent + "REPEAT:");
    super.generateCode(_forever, _indent);
    code.add(_indent + "ENDREPEAT:");
  }

  @Override
  protected void generateCode(Repeat _repeat, String _indent)
  {
    code.add(_indent + "LOOP:");
    super.generateCode(_repeat, _indent); //To change body of generated methods, choose Tools | Templates.
    code.add(_indent + "ENDLOOP:" + _repeat.getText().getText());
  }

  @Override
  protected void generateCode(While _while, String _indent)
  {
    code.add(_indent + "LOOP:" + _while.getText().getText());
    super.generateCode(_while, _indent); //To change body of generated methods, choose Tools | Templates.
    code.add(_indent + "ENDLOOP:");
  }

  @Override
  protected void generateCode(Case _case, String _indent)
  {
    StringList items = _case.getText();
    code.add(_indent + "SELECT:" + items.get(0));
    // code.add(_indent+"");
    for(int i = 0; i < _case.qs.size(); i++)
    {
      code.add(_indent + "CASE:" + items.get(i + 1));
      // code.add(_indent+"");
      generateCode((Subqueue)_case.qs.get(i), _indent + this.getIndent());
      // code.add(_indent+"");
    }
    code.add(_indent + "ENDSELECT:");

  }

}
