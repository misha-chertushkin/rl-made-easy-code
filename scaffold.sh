#!/usr/bin/env bash
# =============================================================================
# scaffold.sh — One-time repo skeleton generator for "RL for LLMs"
#
# Run this ONCE as the author to create the full directory structure,
# stub notebooks, and config files. Then fill notebooks with content.
#
# Usage: bash scaffold.sh
# =============================================================================
set -euo pipefail

# ── Colours ───────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'
info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }

echo -e "\n${BOLD}RL for LLMs — Scaffolding repository${RESET}\n"

# =============================================================================
# 1. DIRECTORY STRUCTURE
# =============================================================================
info "Creating directory structure..."

mkdir -p notebooks/part1_foundations
mkdir -p notebooks/part2_core
mkdir -p notebooks/part3_advanced
mkdir -p notebooks/part4_recipes
mkdir -p data/samples
mkdir -p utils

success "Directories created"

# =============================================================================
# 2. STUB NOTEBOOKS
# =============================================================================
info "Creating stub notebooks..."

# Minimal valid .ipynb that opens in Colab without errors
make_notebook() {
  local path="$1"
  local title="$2"
  local chapter="$3"

  cat > "$path" <<NBEOF
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Chapter ${chapter}: ${title}\n",
    "\n",
    "[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/misha-chertushkin/rl-for-llms/blob/main/${path})\n",
    "\n",
    "> *Companion notebook for **Reinforcement Learning for Large Language Models***"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Install dependencies (Colab only — local users: pip install -r requirements.txt)\n",
    "import sys\n",
    "IN_COLAB = 'google.colab' in sys.modules\n",
    "if IN_COLAB:\n",
    "    %pip install -q -r https://raw.githubusercontent.com/misha-chertushkin/rl-for-llms/main/requirements.txt"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "name": "python",
   "version": "3.10.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
NBEOF
}

# Part 1 — Foundations
make_notebook "notebooks/part1_foundations/01_math_toolkit.ipynb"           "Essential Math Toolkit"                    "1"
make_notebook "notebooks/part1_foundations/02_alignment_gap.ipynb"          "Why LLMs Need RL: The Alignment Gap"       "2"
make_notebook "notebooks/part1_foundations/03_rl_fundamentals.ipynb"        "RL Fundamentals: The Complete Picture"     "3"
make_notebook "notebooks/part1_foundations/04_environment_setup.ipynb"      "Setting Up Your Free Environment"          "4"

# Part 2 — Core Methods
make_notebook "notebooks/part2_core/05_sft.ipynb"                           "Supervised Fine-Tuning & The Cold Start"   "5"
make_notebook "notebooks/part2_core/06_rlhf_ppo.ipynb"                      "RLHF: The Three-Step Dance"                "6"
make_notebook "notebooks/part2_core/07_dpo.ipynb"                           "Direct Preference Optimization"            "7"
make_notebook "notebooks/part2_core/08_online_dpo.ipynb"                    "Online DPO & Iterative Alignment"          "8"
make_notebook "notebooks/part2_core/09_reward_modeling.ipynb"               "Reward Modeling & The Critic"              "9"
make_notebook "notebooks/part2_core/10_grpo_rloo_kto.ipynb"                 "Modern RL Algorithms: GRPO, RLOO, KTO"     "10"

# Part 3 — Advanced Techniques
# Note: chapters 12 split into a=concepts b=implementation; reserve pattern for others if needed
make_notebook "notebooks/part3_advanced/11_verifiers_outcome_rewards.ipynb" "Verifiers & Outcome Rewards"               "11"
make_notebook "notebooks/part3_advanced/12a_reasoning_grpo_concepts.ipynb"  "Reasoning with GRPO: Concepts"             "12a"
make_notebook "notebooks/part3_advanced/12b_reasoning_grpo_deepseek.ipynb"  "Reasoning with GRPO: The DeepSeek Recipe"  "12b"
make_notebook "notebooks/part3_advanced/13_test_time_compute.ipynb"         "Test-Time Compute: Scaling at Inference"   "13"
make_notebook "notebooks/part3_advanced/14_selfplay_constitutional_ai.ipynb" "Self-Play & Constitutional AI"            "14"
make_notebook "notebooks/part3_advanced/15_multiobjective_agentic.ipynb"    "Multi-Objective RL & Agentic Systems"      "15"
make_notebook "notebooks/part3_advanced/16_domain_specific_rl.ipynb"        "Domain-Specific RL: Code, Math, Tools"     "16"

# Part 4 — Recipes
make_notebook "notebooks/part4_recipes/17_recipe_chatbot.ipynb"             "Recipe: Chatbot"                           "17"
make_notebook "notebooks/part4_recipes/18_recipe_reasoner.ipynb"            "Recipe: Reasoner"                          "18"
make_notebook "notebooks/part4_recipes/19_recipe_agent.ipynb"               "Recipe: Agent"                             "19"

success "Stub notebooks created"

# =============================================================================
# 3. SAMPLE DATA
# =============================================================================
info "Creating sample datasets..."

cat > data/samples/preferences.jsonl <<'EOF'
{"prompt": "Explain what reinforcement learning is.", "chosen": "Reinforcement learning is a type of machine learning where an agent learns by interacting with an environment, receiving rewards for good actions and penalties for bad ones.", "rejected": "RL is a thing in ML where you do stuff and get points."}
{"prompt": "What is the KL divergence penalty in RLHF?", "chosen": "The KL divergence penalty prevents the policy from drifting too far from the reference model, ensuring the fine-tuned model stays coherent while still improving according to human preferences.", "rejected": "KL divergence is a math thing that stops the model from changing too much."}
{"prompt": "What is the difference between on-policy and off-policy RL?", "chosen": "On-policy methods (like PPO) learn from data collected by the current policy, while off-policy methods (like DQN) can learn from data collected by older or different policies.", "rejected": "On-policy uses current data and off-policy uses old data."}
EOF

cat > data/samples/prompts.jsonl <<'EOF'
{"prompt": "Explain the intuition behind RLHF in one paragraph."}
{"prompt": "What is reward hacking and why is it a problem?"}
{"prompt": "Compare PPO and GRPO for LLM fine-tuning."}
{"prompt": "What makes DPO simpler than traditional RLHF?"}
{"prompt": "Describe the cold start problem in RL for LLMs."}
EOF

success "Sample datasets created"

# =============================================================================
# 4. UTILITY STUBS
# =============================================================================
info "Creating utility stubs..."

cat > utils/__init__.py << 'EOF'
EOF

cat > utils/data.py <<'EOF'
"""
data.py — Dataset loading and preference pair utilities.
Shared helpers imported by notebooks that need them.
"""


def load_preferences(path: str):
    """Load a .jsonl file of (prompt, chosen, rejected) preference pairs."""
    import json
    with open(path) as f:
        return [json.loads(line) for line in f if line.strip()]


def load_prompts(path: str):
    """Load a .jsonl file of prompts."""
    import json
    with open(path) as f:
        return [json.loads(line)["prompt"] for line in f if line.strip()]
EOF

cat > utils/eval.py <<'EOF'
"""
eval.py — Evaluation helpers: reward scoring, KL divergence, win rate.
"""


def win_rate(chosen_rewards: list[float], rejected_rewards: list[float]) -> float:
    """Fraction of pairs where chosen reward exceeds rejected reward."""
    assert len(chosen_rewards) == len(rejected_rewards)
    wins = sum(c > r for c, r in zip(chosen_rewards, rejected_rewards))
    return wins / len(chosen_rewards)
EOF

cat > utils/viz.py <<'EOF'
"""
viz.py — Plotting helpers for training curves and reward distributions.
"""


def plot_training_curve(steps: list[int], values: list[float], title: str = "Training"):
    """Plot a single training metric over steps."""
    import matplotlib.pyplot as plt
    plt.figure(figsize=(8, 4))
    plt.plot(steps, values)
    plt.xlabel("Step")
    plt.title(title)
    plt.tight_layout()
    plt.show()
EOF

success "Utility stubs created"

# =============================================================================
# 5. GIT INITIALISATION
# =============================================================================
info "Initialising git repository..."

git init -q
git add .
git commit -q -m "chore: initial scaffold"

success "Git repository initialised"

# =============================================================================
# DONE
# =============================================================================
echo ""
echo -e "${BOLD}${GREEN}Scaffold complete.${RESET}"
echo ""
echo -e "  Next steps:"
echo -e "  1. Replace YOUR_USERNAME in notebook headers with your GitHub username"
echo -e "  2. Copy your 3 existing notebooks into notebooks/part2_core/"
echo -e "  3. Fill stubs with content chapter by chapter"
echo ""
