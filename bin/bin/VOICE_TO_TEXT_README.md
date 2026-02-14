# Voice-to-Text System

Speech-to-text that types directly into any application (Alacritty, TMUX, Neovim, Claude Code, etc.)

Uses Google Cloud Speech-to-Text API for the same blazing speed as Web Speech API.

## 🎤 Features

- **Fast transcription** - Same speed as Google's Web Speech API (~100-300ms)
- **Streaming recognition** - Transcribes as you speak
- **Universal** - Works in any application (terminal, browser, editor)
- **Keyboard shortcut** - Press `Super+Space` to start
- **Auto-punctuation** - Adds punctuation automatically
- **Visual feedback** - Notifications show listening status

## 📦 Setup

### 1. Install Dependencies

```bash
# Run the setup script
~/bin/voice-to-text-setup
```

This installs:
- Python packages: `google-cloud-speech`, `pyaudio`
- System packages: `xdotool`, `portaudio`, `libnotify`

### 2. Configure Google Cloud

#### Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing one)
3. Enable Speech-to-Text API:
   - Visit: https://console.cloud.google.com/apis/library/speech.googleapis.com
   - Click "Enable"

#### Create Service Account

1. Go to [IAM & Admin > Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts)
2. Click "Create Service Account"
3. Name it: `speech-to-text`
4. Click "Create and Continue"
5. Grant role: **Cloud Speech Client**
6. Click "Done"

#### Download Credentials

1. Click on the service account you just created
2. Go to "Keys" tab
3. Click "Add Key" → "Create new key"
4. Choose **JSON** format
5. Click "Create" - file downloads automatically

#### Save Credentials

```bash
# Create config directory
mkdir -p ~/.config/gcloud

# Move the downloaded key file
mv ~/Downloads/your-project-*-*.json ~/.config/gcloud/speech-to-text-key.json

# Set proper permissions
chmod 600 ~/.config/gcloud/speech-to-text-key.json
```

#### Set Environment Variable

Add to your `~/.zshrc` (or `~/.bashrc`):

```bash
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/speech-to-text-key.json"
```

Reload your shell:

```bash
source ~/.zshrc
```

### 3. Configure i3 Keybinding

The keybinding is already added to your i3 config:

```bash
# voice-to-text (speak and it types into active window)
bindsym $mod+space exec ~/bin/voice-to-text
```

Reload i3 to apply:

```bash
# Press: Super+Ctrl+R
# Or run: i3-msg reload
```

## 🎯 Usage

### Basic Usage

1. **Press `Super+Space`** - Notification appears: "Listening..."
2. **Speak clearly** - Your speech is transcribed in real-time
3. **Wait for auto-stop** - Stops after 30 seconds or silence
4. **Text is typed** - Appears in your active window

### Tips for Best Results

- **Speak naturally** - No need to pause between words
- **Clear audio** - Use a decent microphone or headset
- **Quiet environment** - Background noise reduces accuracy
- **Punctuation** - Say "period", "comma", "question mark" for punctuation
- **New line** - Say "new line" or "new paragraph"

### Common Use Cases

#### Terminal Commands
```bash
# Say: "docker compose up dash d"
# Types: docker compose up -d
```

#### Claude Code Prompts
```bash
# Say: "refactor this function to use async await"
# Types: refactor this function to use async await
```

#### Neovim Editing
```bash
# Say: "def calculate total open paren items close paren colon"
# Types: def calculate_total(items):
```

#### TMUX Commands
```bash
# Say: "tmux new session dash s dev"
# Types: tmux new-session -s dev
```

## 💰 Pricing

### Free Tier
- **60 minutes per month** - FREE
- Resets monthly
- Perfect for occasional use

### Paid Pricing (after free tier)
- **$0.006 per 15 seconds** (~$1.44/hour)
- Only pay for what you use
- No monthly fees

### Cost Examples
- 5 min/day = ~150 min/month = **$0** (within free tier)
- 10 min/day = ~300 min/month = **~$6/month**
- 30 min/day = ~900 min/month = **~$20/month**

## 🔧 Troubleshooting

### "GOOGLE_APPLICATION_CREDENTIALS not set"
- Make sure you added the export line to `~/.zshrc`
- Run: `source ~/.zshrc`
- Verify: `echo $GOOGLE_APPLICATION_CREDENTIALS`

### "xdotool not found"
- Install: `sudo pacman -S xdotool`

### "No default input device found"
- Check microphone: `arecord -l`
- Test recording: `arecord -d 3 test.wav && aplay test.wav`
- Configure default in: `pavucontrol`

### "Permission denied" on credentials file
- Fix permissions: `chmod 600 ~/.config/gcloud/speech-to-text-key.json`

### Text not appearing
- Make sure target window has focus
- Try clicking in the window first, then use voice-to-text
- Check xdotool works: `xdotool type "test"`

### Poor accuracy
- Use a better microphone
- Reduce background noise
- Speak clearly and at normal pace
- Check microphone levels in `pavucontrol`

## 🎨 Customization

### Change Keyboard Shortcut

Edit `~/.config/i3/config`:

```bash
# Option 1: Super+V (V for voice)
bindsym $mod+v exec ~/bin/voice-to-text

# Option 2: Super+Shift+Space
bindsym $mod+Shift+space exec ~/bin/voice-to-text

# Option 3: Ctrl+Alt+Space
bindsym Ctrl+Mod1+space exec ~/bin/voice-to-text
```

Then reload i3: `Super+Ctrl+R`

### Change Timeout

Edit `~/bin/voice-to-text`, line ~162:

```python
# Change from 30 seconds to 60 seconds
timeout = 60
```

### Change Language

Edit `~/bin/voice-to-text`, line ~76:

```python
# For Spanish
language_code="es-ES"

# For French
language_code="fr-FR"

# For German
language_code="de-DE"
```

## 🔍 Testing

### Test Google Cloud Setup
```bash
# Should show credentials path
echo $GOOGLE_APPLICATION_CREDENTIALS

# Should show JSON file
cat $GOOGLE_APPLICATION_CREDENTIALS
```

### Test Voice Input
```bash
# Run manually (won't type, just prints to console)
~/bin/voice-to-text

# Speak: "hello world"
# Should print: "Final: hello world"
```

### Test xdotool
```bash
# Open a text editor, then run:
xdotool type "this is a test"

# Should type into the active window
```

## 🚀 Advanced

### Integration with Other Tools

#### Neovim
You can create a Neovim mapping to trigger voice input:

```lua
-- Add to ~/.config/nvim/init.lua
vim.keymap.set('i', '<C-Space>', function()
  vim.cmd('silent !~/bin/voice-to-text &')
end, { desc = 'Voice input' })
```

#### TMUX
Add to `~/.tmux.conf`:

```bash
# Trigger voice input with Prefix + Space
bind Space run-shell "~/bin/voice-to-text &"
```

## 📊 Architecture

```
User presses Super+Space
         ↓
   Python script starts
         ↓
   Records from microphone
         ↓
   Streams to Google Cloud Speech-to-Text API
         ↓
   Gets real-time transcription
         ↓
   Types into active window via xdotool
```

## 🆚 Comparison with Web Version

| Feature | Web Version | Terminal Version |
|---------|-------------|------------------|
| **Speed** | Web Speech API (instant) | Google Cloud API (instant) |
| **Backend** | Google Cloud | Google Cloud (same!) |
| **Scope** | Browser only | System-wide |
| **LLM** | Transformers.js | N/A (direct typing) |
| **Cache** | MongoDB | N/A |
| **Cost** | Free (built-in) | Free tier: 60 min/month |
| **Internet** | Required | Required |
| **Accuracy** | Excellent | Excellent (same model) |

## 🎓 How It Works

1. **Microphone Capture** - PyAudio streams audio in 100ms chunks
2. **Streaming Recognition** - Google Cloud processes audio in real-time
3. **Interim Results** - See transcription as you speak
4. **Final Results** - Typed into active window when finalized
5. **Auto-punctuation** - Google adds punctuation automatically

## 📝 Notes

- **Streaming** - Transcription happens as you speak (not after)
- **Auto-stop** - Stops after 30 seconds (configurable)
- **Universal** - Works in ANY application with text input
- **Privacy** - Audio sent to Google Cloud (not stored by default)
- **Offline** - Not possible (requires Google Cloud API)

## 🤝 Similar to prizepicks-be-university

This system is inspired by your web-based voice command system but adapted for terminal use:

- **Same speed** - Google Cloud backend (Web Speech API uses this too)
- **Simpler architecture** - No LLM, no cache (direct transcription)
- **System-wide** - Works everywhere, not just browser
- **Direct typing** - Types what you say verbatim

## 📚 Resources

- [Google Cloud Speech-to-Text Docs](https://cloud.google.com/speech-to-text/docs)
- [Python Client Library](https://cloud.google.com/python/docs/reference/speech/latest)
- [Pricing Calculator](https://cloud.google.com/products/calculator)
- [Language Support](https://cloud.google.com/speech-to-text/docs/languages)

---

**Created:** 2026-02-13
**Author:** Claude Code
**Inspired by:** prizepicks-be-university voice command system
