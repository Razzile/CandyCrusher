#include <substrate.h>
#include "Settings.h"

#define Hook(x, y, z) MSHookFunction(MSFindSymbol(NULL, x), (void*)y, (void**)&z)

/* Original function references */
namespace Original {
    int (*GetNumLives)(void*);
    int (*GetNumLivesDW)(void*);
    int (*AddScore)(void*, int, bool);
    int (*GetNumMovesLeft)(void*);
    int (*StartGame)(void*, bool);
    void (*CreateLevel)(void*, void*, int, void*);
    bool (*IsLevelUnlocked)(void*, int, void*, void*);
    bool (*IsLevelUnlockedDW)(void*, int, void*, void*);
    bool (*IsEpisodeUnlocked)(void*, int, void*, void*, void*);
    bool (*IsEpisodeUnlockedDW)(void*, int, void*, void*, void*);
    bool (*IsDreamworldUnlocked)(void*, void*, void*, void*);
    void (*OnBoosterUsed)(void*);
    bool (*ShouldActivateHammer)(void*);
    bool (*ShouldActivateFreeSwitch)(void*);
}

namespace Hooked {
/* variables */
bool isNewGame = true;
void (*cheat_CompleteLevel)(void*);

/* Modified functions */
int GetNumLives(void *self) {
    bool lives = settings["klives"];
    if (lives) {
        return 99;
    }
    return Original::GetNumLives(self);
}

int GetNumLivesDW(void *self) {
    bool lives = settings["klives"];
    if (lives) {
        return 99;
    }
    return Original::GetNumLivesDW(self);
}

int AddScore(void *self, int scoreVal, bool unk) {
    bool score = settings["kscore"];
    if (score) {
        int mult = settings["kscoreval"];
        scoreVal *= mult;
    }
    return Original::AddScore(self, scoreVal, unk);
}

int GetNumMovesLeft(void *self) {
    static int defecit = -1;
    static int placeholder = 0x7FFFFFFF;
    if (isNewGame) {
        defecit = -1;
        placeholder = 0x7FFFFFFF;
        isNewGame = false;
    }
    int val = settings["kmovesval"];
    int valCopy = val;
    val += Original::GetNumMovesLeft(self);
    if (val < placeholder) {
        defecit++;
        placeholder = val;
    }
    bool moves = settings["kmoves"];
    if (moves) {
        return valCopy - defecit;
    }
    return Original::GetNumMovesLeft(self);
}

int StartGame(void *self, bool unk) {
    isNewGame = true;
    bool autoComplete = settings["kcomplete"];
    if (autoComplete) {
        cheat_CompleteLevel(self);
    }
    return Original::StartGame(self, unk);
}

__attribute__((noinline)) int GetColors() {
    int num = settings["kcolors"];
    if(num > 0 && num <= 6) {
        return num;
    }
    return -1;
}

void CreateLevel(void *self, void *unk1, int colors, void *unk2) {
    int num = GetColors();
    if (num != -1) {
        colors = num;
    }
    return Original::CreateLevel(self, unk1, colors, unk2);
}

bool IsLevelUnlocked(void* self, int unk1, void* unk2, void* unk3) {
    bool level = settings["klevel"];
    if(level) {
        return true;
    }
    return Original::IsLevelUnlocked(self, unk1, unk2, unk3);
}

bool IsLevelUnlockedDW(void* self, int unk1, void* unk2, void* unk3) {
    bool level = settings["klevel"];
    if(level) {
        return true;
    }
    return Original::IsLevelUnlockedDW(self, unk1, unk2, unk3);
}

bool IsEpisodeUnlocked(void* self, int unk1, void* unk2, void* unk3, void* unk4) {
    bool level = settings["klevel"];
    if(level) {
        return true;
    }
    return Original::IsEpisodeUnlocked(self, unk1, unk2, unk3, unk4);
}

bool IsEpisodeUnlockedDW(void* self, int unk1, void* unk2, void* unk3, void* unk4) {
    bool level = settings["klevel"];
    if(level) {
        return true;
    }
    return Original::IsEpisodeUnlockedDW(self, unk1, unk2, unk3, unk4);
}

bool IsDreamworldUnlocked(void *self, void *unk1, void *unk2, void *unk3) {
    bool dream = settings["kdream"];
    if (dream) {
        return true;
    }
    return Original::IsDreamworldUnlocked(self, unk1, unk2, unk3);
}

void OnBoosterUsed(void *self) {
    bool anywhere = settings["kanywhere"];
    bool lollipop = settings["klollipop"];

    if (anywhere || lollipop) {
        return;
    }
    return Original::OnBoosterUsed(self);
}

bool ShouldActivateHammer(void *self) {
    bool lollipop = settings["klollipop"];
    if (lollipop) {
        return true;
    }
    return Original::ShouldActivateHammer(self);
}

bool ShouldActivateFreeSwitch(void *self) {
    bool anywhere = settings["kanywhere"];
    if (anywhere) {
        return true;
    }
    return Original::ShouldActivateFreeSwitch(self);
}

} // Hooks

namespace Crusher {
using namespace Hooked;
__attribute__((constructor))
void Init() {
    cheat_CompleteLevel = (void (*)(void*))MSFindSymbol(NULL, "__ZN10CGameLogic18CheatCompleteLevelEv");

    Hook("__ZN9CSaveData11GetNumLivesEv", GetNumLives, Original::GetNumLives);
    Hook("__ZN6CScore8AddScoreEib", AddScore, Original::AddScore);
    Hook("__ZNK10CGameState15GetNumMovesLeftEv", GetNumMovesLeft, Original::GetNumMovesLeft);
    Hook("__ZN10CGameLogic9StartGameEb", StartGame, Original::StartGame);
    Hook("__ZN16CLevelDefinition13CLevelBuilder11CreateLevelERK7CVectorIiEiRKS1_IPKcE", CreateLevel, Original::CreateLevel);
    Hook("__ZN13CProgressUtil15IsLevelUnlockedEiPK19CCollaborationLocksPK13ILevelStorage", IsLevelUnlocked, Original::IsLevelUnlocked);
    Hook("__ZN23CProgressUtilDreamWorld15IsLevelUnlockedEiPK19CCollaborationLocksPK13ILevelStorage", IsLevelUnlockedDW, Original::IsLevelUnlockedDW);
    Hook("__ZN13CProgressUtil17IsEpisodeUnlockedEiPK7CLevelsPK19CCollaborationLocksPK13ILevelStorage", IsEpisodeUnlocked, Original::IsEpisodeUnlocked);
    Hook("__ZN23CProgressUtilDreamWorld17IsEpisodeUnlockedEiPK7CLevelsPK19CCollaborationLocksPK9CSaveData", IsEpisodeUnlockedDW, Original::IsEpisodeUnlockedDW);
    Hook("__ZN13CProgressUtil20IsDreamworldUnlockedEPK19CCollaborationLocksPK7CLevelsPK13ILevelStorage", IsDreamworldUnlocked, Original::IsDreamworldUnlocked);
    Hook("__ZN18CInGameBoosterMenu13OnBoosterUsedEv", OnBoosterUsed, Original::OnBoosterUsed);
    Hook("__ZN18CInGameBoosterMenu25ShouldActivateCandyHammerEv", ShouldActivateHammer, Original::ShouldActivateHammer);
    Hook("__ZN18CInGameBoosterMenu24ShouldActivateFreeSwitchEv", ShouldActivateFreeSwitch, Original::ShouldActivateFreeSwitch);
}
} // Init
