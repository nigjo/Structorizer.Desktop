/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lu.fisch.structorizer.generators;

import lu.fisch.structorizer.elements.*;
import lu.fisch.utils.StringList;

/**
 * Generates "Source Code" for the browser based "Structogram Editor" at
 * https://nigjo.github.io/structogramview/.
 *
 * @author Jens Hofschröer
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
  protected String generatePreamble(Root _root, String _indent, StringList _varNames)
  {
    return "";
  }

  @Override
  protected void generateCode(Instruction _inst, String _indent)
  {
    StringList text = _inst.getUnbrokenText();
    boolean disabled = _inst.isDisabled(false);
    for(String line : text.toArray())
    {
      addCode(transform(line), _indent, disabled);
    }
  }

  @Override
  protected void generateCode(Alternative _alt, String _indent)
  {
    boolean disabled = _alt.isDisabled(false);

    addCode("IF:" + _alt.getUnbrokenText().getText(), _indent, disabled);
    generateCode(_alt.qTrue, _indent + this.getIndent());
    int elseCount = _alt.qFalse.getSize();
    if(elseCount > 0)
    {
      addCode("ELSE:", _indent, disabled);
      generateCode(_alt.qFalse, _indent + this.getIndent());
    }
    addCode("ENDIF:", _indent, disabled);
  }

  @Override
  protected void generateCode(Call _call, String _indent)
  {
    addCode("CALL:" + _call.getText().getText(), _indent, _call.isDisabled(false));
  }

  @Override
  protected void generateCode(Jump _jump, String _indent)
  {
    addCode("BREAK:" + _jump.getText().getText(), _indent, _jump.isDisabled(false));
  }

  @Override
  protected void generateCode(For _for, String _indent)
  {
    addCode("FOR:" + _for.getText().getText(), _indent, _for.isDisabled(false));
    super.generateCode(_for, _indent); //To change body of generated methods, choose Tools | Templates.
    addCode("ENDFOR:", _indent, _for.isDisabled(false));
  }

  @Override
  protected void generateFooter(Root _root, String _indent)
  {
    super.generateFooter(_root, _indent); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  protected String generateHeader(Root _root, String _indent, String _procName,
      StringList _paramNames, StringList _paramTypes, String _resultType,
      boolean _public)
  {
    if(_procName != null && !_procName.isEmpty())
    {
      addCode("CAPTION:" + _procName, _indent, _root.isDisabled(false));
    }
    return super.generateHeader(
        _root, _indent, _procName, _paramNames, _paramTypes, _resultType, _public);
  }

  @Override
  protected void generateCode(Parallel _para, String _indent)
  {
    addCode("CONCURRENT:", _indent, _para.isDisabled(false));
    for(int i = 0; i < _para.qs.size(); i++)
    {
      addCode("THREAD:", _indent, _para.isDisabled(false));
      generateCode((Subqueue)_para.qs.get(i), _indent + this.getIndent());
    }
    addCode("ENDCONCURRENT:", _indent, _para.isDisabled(false));
  }

  @Override
  protected void generateCode(Forever _forever, String _indent)
  {
    addCode("REPEAT:", _indent, _forever.isDisabled(false));
    super.generateCode(_forever, _indent);
    addCode("ENDREPEAT:", _indent, _forever.isDisabled(false));
  }

  @Override
  protected void generateCode(Repeat _repeat, String _indent)
  {
    addCode("LOOP:", _indent, _repeat.isDisabled(false));
    super.generateCode(_repeat, _indent); //To change body of generated methods, choose Tools | Templates.
    addCode("ENDLOOP:" + _repeat.getText().getText(),
        _indent, _repeat.isDisabled(false));
  }

  @Override
  protected void generateCode(While _while, String _indent)
  {
    addCode("LOOP:" + _while.getText().getText(),
        _indent, _while.isDisabled(false));
    super.generateCode(_while, _indent); //To change body of generated methods, choose Tools | Templates.
    addCode("ENDLOOP:", _indent, _while.isDisabled(false));
  }

  @Override
  protected void generateCode(Case _case, String _indent)
  {
    StringList items = _case.getText();
    addCode("SELECT:" + items.get(0), _indent, _case.isDisabled(false));
    // code.add(_indent+"");
    for(int i = 0; i < _case.qs.size() - 1; i++)
    {
      addCode("CASE:" + items.get(i + 1), _indent, _case.isDisabled(false));
      // code.add(_indent+"");
      generateCode((Subqueue)_case.qs.get(i), _indent + this.getIndent());
      // code.add(_indent+"");
    }
    String defaultCase = items.get(_case.qs.size());
    if(!defaultCase.equals("%"))
    {
      addCode("DEFAULT:", _indent, _case.isDisabled(false));
      generateCode((Subqueue)_case.qs.get(_case.qs.size() - 1), _indent + this.getIndent());
    }

    addCode("ENDSELECT:", _indent, _case.isDisabled(false));
  }

}
