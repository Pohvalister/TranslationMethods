#ifndef INC_2LAB_PARSER_H
#define INC_2LAB_PARSER_H

#include <memory>
#include <vector>
#include "lexicalAnalyzer.h"


struct GrammarNode{
    enum node_type {Ex1, Ex2, Eo1, Eo2, Ea1,Ea2,T,TERM};
    std::string interp;
    node_type type;
    std::vector<std::shared_ptr<GrammarNode>> children;

    GrammarNode(node_type t,std::string str):type(t),interp(str){}
};

struct parser {
    std::shared_ptr<GrammarNode> parse(std::string);

private:
    std::shared_ptr<GrammarNode> Ex1(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> Ex2(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> Eo1(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> Eo2(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> Ea1(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> Ea2(std::shared_ptr<lexicalAnalyzer>);
    std::shared_ptr<GrammarNode> T(std::shared_ptr<lexicalAnalyzer>);
};

struct parsing_exception : std::exception{
};

#endif //INC_2LAB_PARSER_H
