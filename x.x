// 作者：pxx917144686
// 日期：2025-04-11
// ============== 头文件 ==============
#include <substrate.h>
#include <Foundation/Foundation.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <stdint.h>

// 原始函数指针
void (*original_sub_4170)(void);
void (*original_sub_151C8C)(void);
void (*original_sub_44D748)(void);
int64_t (*original_sub_1516E0)(int a1);
int64_t (*original_sub_2E4320)(int64_t a1, ...);
int64_t (*original_sub_44D91C)(void);
int64_t (*original_sub_1514E4)(void);
int64_t (*original_sub_44D7C4)(int64_t a1, ...);
void (*original_sub_2E4468)(void);     // 新增：处理闪退
int64_t (*original_sub_151C14)(void);  // 新增：处理网络验证
int64_t (*original_sub_2E38C8)(void);  // 新增：处理网络验证

// 全局变量地址
int64_t *authStatus = (int64_t *)0x8B3660;   // 主授权状态
int32_t *dword_7CFE80 = (int32_t *)0x7CFE80; // 额外授权标志
int32_t *dword_848798 = (int32_t *)0x848798; // 额外授权标志

// Hook 后的 sub_4170 函数（初始化并设置授权状态）
void hooked_sub_4170() {
    *authStatus = 1;          // 设置主授权状态为已授权
    *dword_7CFE80 = 0x12345678; // 设置额外标志
    *dword_848798 = 0x87654321; // 设置额外标志
    original_sub_4170();
}

// Hook 后的 sub_151C8C 函数（阻止未授权弹窗）
void hooked_sub_151C8C() {
    return; // 直接返回，不执行弹窗逻辑
}

// Hook 后的 sub_44D748 函数（确保状态设置正确）
void hooked_sub_44D748() {
    *authStatus = 1;          // 确保授权状态
    *dword_7CFE80 = 0x12345678;
    *dword_848798 = 0x87654321;
    original_sub_44D748();
}

// Hook 后的 sub_1516E0 函数（处理条件检查）
int64_t hooked_sub_1516E0(int a1) {
    *authStatus = 1; // 确保状态一致
    return 1;        // 强制返回授权成功
}

// Hook 后的 sub_2E4320 函数（处理动态条件检查）
int64_t hooked_sub_2E4320(int64_t a1, int64_t a2, int64_t a3, int64_t a4, int64_t a5, int64_t a6, int64_t a7, int64_t a8, int64_t a9, int64_t a10, int64_t a11, int64_t a12, int64_t a13, int64_t a14, int64_t a15, int64_t a16, int64_t a17, int64_t a18, int64_t a19, int64_t a20, int64_t a21, int64_t a22, int64_t a23, int64_t a24, int64_t a25, int64_t a26, int64_t a27, int64_t a28, int64_t a29, int64_t a30, int64_t a31, int64_t a32, int64_t a33, int64_t a34, int64_t a35, int64_t a36, int64_t a37, int64_t a38, int64_t a39, int64_t a40, int64_t a41, int64_t a42, int64_t a43, int64_t a44, int64_t a45) {
    *dword_7CFE80 = 0x12345678; // 强制设置全局变量
    *authStatus = 1;           // 确保状态一致
    return 1;                  // 强制返回授权成功，不调用原始函数
}

// Hook 后的 sub_44D91C 函数（处理参数检查）
int64_t hooked_sub_44D91C() {
    *dword_848798 = 0x87654321; // 强制设置全局变量
    *authStatus = 1;           // 确保状态一致
    return 1;                  // 强制返回授权成功
}

// Hook 后的 sub_1514E4 函数（处理内部状态检查）
int64_t hooked_sub_1514E4() {
    *authStatus = 1; // 确保状态一致
    return 1;        // 强制返回授权成功
}

// Hook 后的 sub_44D7C4 函数（处理动态函数调用）
int64_t hooked_sub_44D7C4(int64_t a1, int64_t a2, int64_t a3, int64_t a4, int64_t a5, int64_t a6, int64_t a7, int64_t a8, int64_t a9, int64_t a10, int64_t a11, int64_t a12, int64_t a13, int64_t a14, int64_t a15, int64_t a16, int64_t a17, int64_t a18, int64_t a19, int64_t a20, int64_t a21, int64_t a22, int64_t a23, int64_t a24, int64_t a25, int64_t a26, int64_t a27, int64_t a28, int64_t a29, int64_t a30, int64_t a31, int64_t a32, int64_t a33, int64_t a34, int64_t a35, int64_t a36, int64_t a37, int64_t a38, int64_t a39, int64_t a40, int64_t a41, int64_t a42, int64_t a43, int64_t a44, int64_t a45, int64_t a46, int64_t a47, int64_t a48, int64_t a49) {
    *dword_848798 = 0x87654321; // 强制设置全局变量
    *authStatus = 1;           // 确保状态一致
    return 1;                  // 强制返回授权成功，不调用原始函数
}

// Hook 后的 sub_2E4468 函数（阻止闪退）
void hooked_sub_2E4468() {
    return; // 直接返回，不执行闪退逻辑
}

// Hook 后的 sub_151C14 函数（处理网络验证）
int64_t hooked_sub_151C14() {
    *authStatus = 1; // 确保状态一致
    return 1;        // 强制返回授权成功
}

// Hook 后的 sub_2E38C8 函数（处理网络验证）
int64_t hooked_sub_2E38C8() {
    *authStatus = 1; // 确保状态一致
    return 1;        // 强制返回授权成功
}

// 动态定位函数（改进版）
void* findSymbolWithPattern(const char *symbolName, unsigned char *pattern, size_t patternLength) {
    void *target = MSFindSymbol(NULL, symbolName);
    if (target) {
        return target;
    }
    // 可选：添加更健壮的模式匹配逻辑
    return NULL;
}

// 插件构造函数
%ctor {
    // 在插件加载时一次性设置全局变量
    *authStatus = 1;
    *dword_7CFE80 = 0x12345678;
    *dword_848798 = 0x87654321;

    // Hook sub_4170（初始化并设置授权状态）
    unsigned char pattern_sub_4170[] = {0xF8, 0x5F, 0xBC, 0xA9, 0xF6, 0x57, 0x01, 0xA9, 0xF4, 0x4F, 0x02, 0xA9, 0xFD, 0x7B, 0x03, 0xA9, 0xFD, 0xC3, 0x00, 0x91, 0xA0, 0x2C, 0x00, 0xB0, 0x00, 0x38, 0x28, 0x91, 0x41, 0x00, 0x80, 0x52};
    void *target_sub_4170 = findSymbolWithPattern("_sub_4170", pattern_sub_4170, sizeof(pattern_sub_4170));
    if (target_sub_4170) {
        MSHookFunction(target_sub_4170, (void *)hooked_sub_4170, (void **)&original_sub_4170);
    }

    // Hook sub_151C8C（阻止未授权弹窗）
    unsigned char pattern_sub_151C8C[] = {0xE0, 0x03, 0x14, 0xAA, 0x80, 0x18, 0x11, 0x94, 0x68, 0x30, 0x00, 0x90, 0x08, 0x5D, 0x4A, 0xB9, 0x69, 0x30, 0x00, 0x90, 0x29, 0x61, 0x4A, 0xB9, 0x08, 0x01, 0x09, 0x4A, 0xE9, 0xA4, 0x94, 0x52};
    void *target_sub_151C8C = findSymbolWithPattern("_sub_151C8C", pattern_sub_151C8C, sizeof(pattern_sub_151C8C));
    if (target_sub_151C8C) {
        MSHookFunction(target_sub_151C8C, (void *)hooked_sub_151C8C, (void **)&original_sub_151C8C);
    }

    // Hook sub_44D748（确保状态设置）
    unsigned char pattern_sub_44D748[] = {0x28, 0x00, 0x80, 0x52, 0x88, 0xC2, 0x20, 0x39, 0xE0, 0x03, 0x16, 0xAA, 0x7C, 0x2B, 0x05, 0x94, 0xE0, 0x03, 0x15, 0xAA, 0x7A, 0x2B, 0x05, 0x94, 0xC8, 0x1F, 0x00, 0xF0, 0x08, 0x99, 0x47, 0xB9};
    void *target_sub_44D748 = findSymbolWithPattern("_sub_44D748", pattern_sub_44D748, sizeof(pattern_sub_44D748));
    if (target_sub_44D748) {
        MSHookFunction(target_sub_44D748, (void *)hooked_sub_44D748, (void **)&original_sub_44D748);
    }

    // Hook sub_1516E0（处理条件检查）
    unsigned char pattern_sub_1516E0[] = {0x1F, 0x01, 0x19, 0x6B, 0xE8, 0x17, 0x9F, 0x1A, 0xA8, 0x43, 0x13, 0xB8, 0xA9, 0x32, 0x40, 0xF9, 0x28, 0x59, 0x68, 0xF8, 0x00, 0x01, 0x1F, 0xD6, 0xA1, 0x82, 0x4B, 0xA9, 0x8C, 0x1B, 0x11, 0x94};
    void *target_sub_1516E0 = findSymbolWithPattern("_sub_1516E0", pattern_sub_1516E0, sizeof(pattern_sub_1516E0));
    if (target_sub_1516E0) {
        MSHookFunction(target_sub_1516E0, (void *)hooked_sub_1516E0, (void **)&original_sub_1516E0);
    }

    // Hook sub_2E4320（处理动态条件检查）
    unsigned char pattern_sub_2E4320[] = {0x1E, 0xDB, 0xFB, 0x97, 0x48, 0x27, 0x00, 0xF0, 0x08, 0x81, 0x4E, 0xB9, 0x49, 0x27, 0x00, 0xF0, 0x29, 0x85, 0x4E, 0xB9, 0x08, 0x01, 0x09, 0x2A, 0x29, 0xC2, 0x80, 0x52, 0xC9, 0x82, 0xA3, 0x72};
    void *target_sub_2E4320 = findSymbolWithPattern("_sub_2E4320", pattern_sub_2E4320, sizeof(pattern_sub_2E4320));
    if (target_sub_2E4320) {
        MSHookFunction(target_sub_2E4320, (void *)hooked_sub_2E4320, (void **)&original_sub_2E4320);
    }

    // Hook sub_44D91C（处理参数检查）
    unsigned char pattern_sub_44D91C[] = {0x28, 0x17, 0x00, 0xB0, 0x01, 0x51, 0x43, 0xF9, 0xE0, 0x03, 0x15, 0xAA, 0x01, 0x2B, 0x05, 0x94, 0xFD, 0x03, 0x1D, 0xAA, 0x11, 0x2B, 0x05, 0x94, 0xF7, 0x03, 0x00, 0xAA, 0xC8, 0x1F, 0x00, 0xF0};
    void *target_sub_44D91C = findSymbolWithPattern("_sub_44D91C", pattern_sub_44D91C, sizeof(pattern_sub_44D91C));
    if (target_sub_44D91C) {
        MSHookFunction(target_sub_44D91C, (void *)hooked_sub_44D91C, (void **)&original_sub_44D91C);
    }

    // Hook sub_1514E4（处理内部状态检查）
    unsigned char pattern_sub_1514E4[] = {0xA8, 0x9E, 0x40, 0xF9, 0x16, 0x01, 0x00, 0xB9, 0xA8, 0x03, 0x58, 0xB8, 0x1F, 0x01, 0x18, 0x6B, 0xE9, 0xA7, 0x9F, 0x1A, 0xA9, 0xC3, 0x15, 0xB8, 0xAA, 0x92, 0x40, 0xF9, 0x49, 0x59, 0x69, 0xF8};
    void *target_sub_1514E4 = findSymbolWithPattern("_sub_1514E4", pattern_sub_1514E4, sizeof(pattern_sub_1514E4));
    if (target_sub_1514E4) {
        MSHookFunction(target_sub_1514E4, (void *)hooked_sub_1514E4, (void **)&original_sub_1514E4);
    }

    // Hook sub_44D7C4（处理动态函数调用）
    unsigned char pattern_sub_44D7C4[] = {0xC8, 0x1F, 0x00, 0xF0, 0x08, 0xE1, 0x47, 0xB9, 0xC9, 0x1F, 0x00, 0xF0, 0x29, 0xE5, 0x47, 0xB9, 0x08, 0x7D, 0x09, 0x1B, 0x09, 0xEA, 0x94, 0x52, 0xC9, 0x5C, 0xA1, 0x72, 0x08, 0x01, 0x09, 0x0A};
    void *target_sub_44D7C4 = findSymbolWithPattern("_sub_44D7C4", pattern_sub_44D7C4, sizeof(pattern_sub_44D7C4));
    if (target_sub_44D7C4) {
        MSHookFunction(target_sub_44D7C4, (void *)hooked_sub_44D7C4, (void **)&original_sub_44D7C4);
    }

    // Hook sub_2E4468（阻止闪退）
    unsigned char pattern_sub_2E4468[] = {0xE0, 0x03, 0x15, 0xAA, 0x80, 0x18, 0x11, 0x94, 0x68, 0x30, 0x00, 0x90, 0x08, 0x5D, 0x4A, 0xB9, 0x69, 0x30, 0x00, 0x90, 0x29, 0x61, 0x4A, 0xB9, 0x08, 0x01, 0x09, 0x4A, 0xE9, 0xA4, 0x94, 0x52};
    void *target_sub_2E4468 = findSymbolWithPattern("_sub_2E4468", pattern_sub_2E4468, sizeof(pattern_sub_2E4468));
    if (target_sub_2E4468) {
        MSHookFunction(target_sub_2E4468, (void *)hooked_sub_2E4468, (void **)&original_sub_2E4468);
    }

    // Hook sub_151C14（处理网络验证）
    unsigned char pattern_sub_151C14[] = {0xF8, 0x5F, 0xBC, 0xA9, 0xF6, 0x57, 0x01, 0xA9, 0xF4, 0x4F, 0x02, 0xA9, 0xFD, 0x7B, 0x03, 0xA9, 0xFD, 0xC3, 0x00, 0x91, 0xA0, 0x2C, 0x00, 0xB0, 0x00, 0x38, 0x28, 0x91, 0x41, 0x00, 0x80, 0x52};
    void *target_sub_151C14 = findSymbolWithPattern("_sub_151C14", pattern_sub_151C14, sizeof(pattern_sub_151C14));
    if (target_sub_151C14) {
        MSHookFunction(target_sub_151C14, (void *)hooked_sub_151C14, (void **)&original_sub_151C14);
    }

    // Hook sub_2E38C8（处理网络验证）
    unsigned char pattern_sub_2E38C8[] = {0xF8, 0x5F, 0xBC, 0xA9, 0xF6, 0x57, 0x01, 0xA9, 0xF4, 0x4F, 0x02, 0xA9, 0xFD, 0x7B, 0x03, 0xA9, 0xFD, 0xC3, 0x00, 0x91, 0xA0, 0x2C, 0x00, 0xB0, 0x00, 0x38, 0x28, 0x91, 0x41, 0x00, 0x80, 0x52};
    void *target_sub_2E38C8 = findSymbolWithPattern("_sub_2E38C8", pattern_sub_2E38C8, sizeof(pattern_sub_2E38C8));
    if (target_sub_2E38C8) {
        MSHookFunction(target_sub_2E38C8, (void *)hooked_sub_2E38C8, (void **)&original_sub_2E38C8);
    }
}