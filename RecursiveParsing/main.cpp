#include <iostream>
#include "lexicalAnalyzer.h"
#include "parser.h"
#include <graphviz/gvc.h>
#include "fstream"

using namespace std;

char* LABEL = "label";
char* SHAPE = "shape";
char* POLYGON = "polygon";
char* OVAL = "oval";
static int count=0;

Agnode_t* transfer_tree_to_graph(std::shared_ptr<GrammarNode> node, Agraph_t* graph){
    char* node_name = &(string("node_"+to_string(count++)))[0];
    Agnode_t *gr_node =  agnode(graph,node_name,true);
    char* node_label = &(node->interp)[0];
    agset(gr_node,LABEL,node_label);
    char* node_shape = (node->type==node->TERM ? POLYGON : OVAL);
    agset(gr_node,SHAPE,node_shape);

    for (std::shared_ptr<GrammarNode> child : node->children){
        Agnode_t *gr_child = transfer_tree_to_graph(child,graph);
        agedge(graph,gr_node,gr_child, nullptr,true);
    }

    return gr_node;
}

void create_pic_from_tree(string file_name,std::shared_ptr<GrammarNode> tree){

    GVC_t* gvc = gvContext();

    char* graph_name = "boolGraph";
    Agraph_t *graph = agopen(graph_name,Agstrictdirected,nullptr);
    transfer_tree_to_graph(tree,graph);

    gvLayout(gvc,graph,"dot");

    FILE* pic_file = fopen((file_name + ".png").c_str(), "w");
    gvRender(gvc,graph,"png", pic_file);
    gvFreeLayout(gvc,graph);
    agclose(graph);

    fclose(pic_file);
}

int main() {

    std::string str = " asd or ( a and  o        \n ) ";
    lexicalAnalyzer a(str);
    token t;
    while ((t = a.currToken()) != END) {
        a.nextToken();
        std::cout << t << '\n';
    }
    parser p;
    auto x = p.parse(str);
    auto x1 = x.get();
    create_pic_from_tree("asos",x);
    return 0;
}