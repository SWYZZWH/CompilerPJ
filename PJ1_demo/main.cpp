#include <iostream>
#include <string.h>
#include <stdio.h>
#include <iomanip>
#include "lexer.h"
using namespace std;

int yylex();
extern "C" FILE* yyin;
extern "C" char* yytext;

int main(int argc, char** argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            cerr << "Cannot open file." << endl;
            return 1;
        } else {
            yyin = file;
        }
    } else {
        yyin = stdin;
    }
    
    // output header
    cout<<setw(5)<<left<<"Row"<<setw(5)<<left<<"Col"<<setw(20)<<left<<"Type"<<"Token/Error"<<endl;

    int token_num = 0;
    int error_num = 0;
    while (true) {
        int n = yylex();
        string type = "";
        string token = "";
	
        if (n == T_EOF) break;
        switch(n) {
            case INTEGER:
                // overflow? (see file test20.pcat)
                type = "integer";
                token = yytext;
		try{
			stoi(yytext);
		}
		catch(invalid_argument& e){
			cout<<"invalid_argument"<<endl;
			token = "";
			type = "invaild error";
			error_num++;
			break;
		}
		catch(out_of_range& e){
			//cout<<"out of range"<<endl;
			token = "";
			type = "overflow error";
			error_num++;
			break;
		}
		catch(...){
		};
		token_num++;
                break;
            case REAL:
		// overflow?
                type = "real";
                token = yytext;
		try{
			stoi(yytext);
		}
		catch(invalid_argument& e){
			cout<<"invalid_argument"<<endl;
			token = "";
			type = "invalid error";
			error_num++;
			break;
		}
		catch(out_of_range& e){
			//cout<<"out of range"<<endl;
			token = "";
			type = "overflow error";
			error_num++;
			break;
		}
		catch(...){
		};
		token_num++;
                break;
	    case WS:
                type = "whitespace";
                continue;
	    case RESERVED:
		type = "reserved";
		token = yytext;
                token_num++;
		break;
	    case ID:
		// overflow?
		type = "ID";
		token = yytext;
                token_num++;
		break;
             case STRING:
                // overflow?
		type = "string";
		token = yytext;
                token_num++;
		break;
             case OPERATOR:
		type = "operator";
		token = yytext;
                token_num++;
		break;
             case DELIMITER:
		type = "delimitor";
		token = yytext;
                token_num++;
		break;
            // other cases?
            default:
                type = "error";
                token = yytext;
		error_num++;
        }
        cout<<setw(5)<<left<<"rpos"<<setw(5)<<left<<"cpos"<<setw(20)<<left<<type<<token<<endl;
    }
    
    // count num of tokens and errors? 
    cout<<"tokens: "<<token_num<<" errors: "<<error_num<<endl;
    
    return 0;
}
