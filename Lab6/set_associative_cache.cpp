#include "set_associative_cache.h"
#include "string"
#include <iostream>
#include <fstream>
#include <vector>
#include <climits>
using namespace std;


string hexstr_to_binstr_set(int size, string hex)
{
    string bin;
    for (int i = hex.size() - 1; i >= 0; i--)
    {
        switch (hex[i])
        {
        case '0':
            bin.insert(0, "0000");
            break;
        case '1':
            bin.insert(0, "0001");
            break;
        case '2':
            bin.insert(0, "0010");
            break;
        case '3':
            bin.insert(0, "0011");
            break;
        case '4':
            bin.insert(0, "0100");
            break;
        case '5':
            bin.insert(0, "0101");
            break;
        case '6':
            bin.insert(0, "0110");
            break;
        case '7':
            bin.insert(0, "0111");
            break;
        case '8':
            bin.insert(0, "1000");
            break;
        case '9':
            bin.insert(0, "1001");
            break;
        case 'a':
            bin.insert(0, "1010");
            break;
        case 'b':
            bin.insert(0, "1011");
            break;
        case 'c':
            bin.insert(0, "1100");
            break;
        case 'd':
            bin.insert(0, "1101");
            break;
        case 'e':
            bin.insert(0, "1110");
            break;
        case 'f':
            bin.insert(0, "1111");
            break;
        default:
            break;
        }
    }
    while (bin.size() < size)
    {
        bin.insert(0, "0");
    }
    return bin;
}


long long binstr_to_decnum_set(string bin)
{
    long long dec = 0;
    for (int i = 0, p = bin.size() - 1; i < bin.size(); i++, p--)
    {
        if (bin[i] == '1') dec += (long long)pow(2, p);
    }
    return dec;
}


float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;

    /*write your code HERE*/
    ifstream in;
    in.open(filename);

    total_num = 0;

    int offset_size, index_size, tag_size;
    offset_size = (int)log2(block_size);
    index_size = (int)log2(cache_size/way) - offset_size;
    tag_size = 32 - index_size - offset_size;

    /* | offset | index | tag | */

    string addr, address, offset, index, tag, tag_index;
    int block_num = cache_size / block_size;
    int set_num = cache_size / (block_size * way);
    vector<string> temp1(way);
    vector<vector<string>>cache;
    cache.resize(set_num, temp1);

    vector<int> temp2(way);
    vector<vector<int>>LRU;
    LRU.resize(set_num, temp2);

    long long block_addr, idx;

    while (in >> addr)
    {
        total_num++;

        address = hexstr_to_binstr_set(32, addr);
        offset = address.substr(0, offset_size);
        index = address.substr(offset_size, index_size);
        tag = address.substr(index_size, tag_size);


        block_addr = binstr_to_decnum_set(address) / block_size;
        idx = block_addr % set_num;

        bool done = false;      //address有沒有找到空位or hit
        for (int i = 0; i < cache[idx].size(); i++) {
            if (cache[idx][i].empty()) {
                cache[idx][i] = tag;
                LRU[idx][i] = total_num;
                done = true;
                break;
            }
            else if (cache[idx][i] == tag) {
                LRU[idx][i] = total_num;
                hit_num++;
                done = true;
                break;
            }
        }
        if (!done) {
            int replace_idx;
            int min=INT_MAX;
            for (int i = 0; i < cache[idx].size(); i++) {
                if (min > LRU[idx][i]) {
                    min = LRU[idx][i];
                    replace_idx = i;
                }
            }
            cache[idx][replace_idx] = tag;
            LRU[idx][replace_idx] = total_num;
        }

    }

    LRU.clear();
    cache.clear();
    in.close();
    
    return (float)hit_num/total_num;
}

