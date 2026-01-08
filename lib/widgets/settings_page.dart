import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../services/theme_service.dart';

class SettingsPage extends StatefulWidget {
  final ThemeService themeService;

  const SettingsPage({super.key, required this.themeService});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionHeader('Erscheinungsbild', Icons.palette_outlined),
          const SizedBox(height: 8),
          
          // Theme Mode Card
          Card(
            child: Column(
              children: [
                _buildThemeModeOption(
                  title: 'System',
                  subtitle: 'Folgt den Systemeinstellungen',
                  icon: Icons.brightness_auto,
                  mode: ThemeModeOption.system,
                ),
                const Divider(height: 1),
                _buildThemeModeOption(
                  title: 'Hell',
                  subtitle: 'Helles Erscheinungsbild',
                  icon: Icons.light_mode,
                  mode: ThemeModeOption.light,
                ),
                const Divider(height: 1),
                _buildThemeModeOption(
                  title: 'Dunkel',
                  subtitle: 'Dunkles Erscheinungsbild',
                  icon: Icons.dark_mode,
                  mode: ThemeModeOption.dark,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Colors Section
          _buildSectionHeader('Farben', Icons.color_lens_outlined),
          const SizedBox(height: 8),
          
          Card(
            child: Column(
              children: [
                // Material You Toggle
                SwitchListTile(
                  title: const Text('Material You'),
                  subtitle: Text(
                    'Farben automatisch aus Hintergrund ableiten',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  value: widget.themeService.useMaterialYou,
                  onChanged: (value) {
                    widget.themeService.setUseMaterialYou(value);
                    setState(() {});
                  },
                ),
                
                // Show accent color picker only when Material You is off
                if (!widget.themeService.useMaterialYou) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.format_paint,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    title: const Text('Akzentfarbe'),
                    subtitle: Text(
                      'Wähle deine bevorzugte Farbe',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                    trailing: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: widget.themeService.accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 2,
                        ),
                      ),
                    ),
                    onTap: () => _showColorPicker(context),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // About Section
          _buildSectionHeader('Über', Icons.info_outlined),
          const SizedBox(height: 8),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.speed,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  title: const Text('Speed Reader'),
                  subtitle: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Current Color Preview
          Center(
            child: Column(
              children: [
                Text(
                  'Aktive Farbe',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary,
                        colorScheme.tertiary,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeModeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeModeOption mode,
  }) {
    final isSelected = widget.themeService.themeMode == mode;
    final colorScheme = Theme.of(context).colorScheme;
    
    return RadioListTile<ThemeModeOption>(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 13,
        ),
      ),
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected 
              ? colorScheme.primaryContainer 
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected 
              ? colorScheme.onPrimaryContainer 
              : colorScheme.onSurfaceVariant,
        ),
      ),
      value: mode,
      groupValue: widget.themeService.themeMode,
      onChanged: (value) {
        if (value != null) {
          widget.themeService.setThemeMode(value);
          setState(() {});
        }
      },
    );
  }

  Future<void> _showColorPicker(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    Color selectedColor = widget.themeService.accentColor;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Akzentfarbe wählen'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: selectedColor,
            onColorChanged: (color) {
              selectedColor = color;
            },
            pickersEnabled: const {
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.wheel: true,
            },
            enableShadesSelection: true,
            heading: Text(
              'Farbe auswählen',
              style: TextStyle(color: colorScheme.onSurface),
            ),
            subheading: Text(
              'Schattierung auswählen',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            wheelSubheading: Text(
              'Farbe und Schattierung',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () {
              widget.themeService.setAccentColor(selectedColor);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('Übernehmen'),
          ),
        ],
      ),
    );
  }
}
