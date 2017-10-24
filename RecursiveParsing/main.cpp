#include <iostream>
#include "lexicalAnalyzer.h"
#include "parser.h"
#include "graphviz/gvc.h"

int main() {
    std::string str = " asd or ( a xor  not r and r or ( o xor x xor k)         \n ) ";
    lexicalAnalyzer a(str);
    token t;
    while ((t = a.currToken()) != END){
        a.nextToken();
        std::cout<< t<<'\n';
    }
    parser p;
    auto x = p.parse(str);
    auto x1 = x.get();
    return 0;
}