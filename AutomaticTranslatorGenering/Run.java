/***
 * Excerpted from "The Definitive ANTLR 4 Reference",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tpantlr2 for more book information.
***/

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.*;
import java.lang.Object;
import java.util.Scanner;

public class Run {
    public static void main(String[] args) throws Exception {
        String inputFile = null;
        if ( args.length>0 ) inputFile = args[0];
        InputStream is = System.in;
        if ( inputFile!=null ) {
            is = new FileInputStream(inputFile);
        }

        Scanner s = new Scanner(new File("./ax.in"));
        String expr="";
        while (s.hasNext())
            expr += (s.nextLine() + "\n");              // get first expression

		CPP_GrammarParser parser = new CPP_GrammarParser(null); // share single parser instance
  		parser.setBuildParseTree(false);          // don't need trees

        // create new lexer and token stream for each line (expression)
        ANTLRInputStream input = new ANTLRInputStream(expr+"\n");
        CPP_GrammarLexer lexer = new CPP_GrammarLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        parser.setInputStream(tokens); // notify parser of new token stream
        //System.out.println(parser.stat());                 // start the parser
        parser.stat();
    }
}