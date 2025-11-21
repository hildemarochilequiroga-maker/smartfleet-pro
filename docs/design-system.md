# Design System - SmartFleet Pro

## 📋 Descripción General

Este documento describe el Design System completo de SmartFleet Pro, implementado siguiendo Material Design 3. El sistema garantiza consistencia visual, accesibilidad y reutilización de componentes en toda la aplicación.

## 🎨 Paleta de Colores

### Colores Primarios

| Color | Código | Uso |
|-------|--------|-----|
| Primary | `#2563EB` | Acciones principales, CTA buttons |
| Primary Light | `#DBEAFE` | Fondos destacados, badges |
| Primary Dark | `#1E40AF` | Hover states, variantes oscuras |

### Colores Secundarios

| Color | Código | Uso |
|-------|--------|-----|
| Secondary | `#10B981` | Acciones secundarias, estados de éxito |
| Secondary Light | `#D1FAE5` | Fondos de confirmación |
| Secondary Dark | `#059669` | Estados hover secundarios |

### Colores de Estado

| Estado | Color | Código | Uso |
|--------|-------|--------|-----|
| Error | Rojo | `#EF4444` | Errores, validaciones fallidas |
| Warning | Naranja | `#F59E0B` | Advertencias, alertas |
| Info | Azul | `#3B82F6` | Información, tooltips |
| Success | Verde | `#10B981` | Confirmaciones, operaciones exitosas |

### Colores de Vehículos

| Estado | Color | Código | Descripción |
|--------|-------|--------|-------------|
| Moving | Verde | `#10B981` | Vehículo en movimiento |
| Stopped | Rojo | `#EF4444` | Vehículo detenido |
| No Signal | Gris | `#6B7280` | Sin señal GPS |

### Tema Claro vs Oscuro

#### Tema Claro
- **Fondo principal**: `#FFFFFF`
- **Superficie**: `#F9FAFB`
- **Texto primario**: `#111827`
- **Texto secundario**: `#6B7280`
- **Bordes**: `#E5E7EB`

#### Tema Oscuro
- **Fondo principal**: `#111827`
- **Superficie**: `#1F2937`
- **Texto primario**: `#F9FAFB`
- **Texto secundario**: `#9CA3AF`
- **Bordes**: `#374151`

## ✍️ Tipografía

### Fuentes

- **UI General**: Inter (Google Fonts)
- **Números/Monoespaciados**: Roboto Mono (Google Fonts)

### Escala Tipográfica

| Estilo | Tamaño | Peso | Uso |
|--------|--------|------|-----|
| **Heading 1** | 24px | Bold (700) | Títulos de página principales |
| **Heading 2** | 20px | Bold (700) | Títulos de sección, headers de cards |
| **Heading 3** | 18px | Semi-Bold (600) | Subtítulos, headers de modal |
| **Heading 4** | 16px | Semi-Bold (600) | Títulos de listas, mini-headers |
| **Body Large** | 16px | Regular (400) | Contenido principal destacado |
| **Body Medium** | 14px | Regular (400) | Contenido general |
| **Caption** | 12px | Regular (400) | Texto secundario, metadatos |

### Estilos Especializados

- **Button Text**: 16px, Medium (500), Inter
- **Input Text**: 16px, Regular (400), Inter
- **Input Label**: 14px, Medium (500), Inter
- **Link**: 16px, Medium (500), Inter + underline
- **Numbers Large**: 32px, Medium (500), Roboto Mono
- **Numbers Small**: 20px, Regular (400), Roboto Mono

## 📐 Sistema de Espaciado

```dart
AppSpacing.xs   = 4px   // Espaciado mínimo
AppSpacing.sm   = 8px   // Elementos muy cercanos
AppSpacing.md   = 12px  // Espaciado normal
AppSpacing.lg   = 16px  // Separación estándar
AppSpacing.xl   = 24px  // Secciones
AppSpacing.xxl  = 32px  // Grandes separaciones
AppSpacing.xxxl = 48px  // Espaciado máximo
```

## 🔲 Border Radius

```dart
AppRadius.xs   = 4px   // Badges, chips pequeños
AppRadius.sm   = 8px   // Inputs, botones secundarios
AppRadius.md   = 12px  // Cards, modales
AppRadius.lg   = 16px  // Cards destacados
AppRadius.xl   = 24px  // Headers, elementos grandes
AppRadius.full = 999px // Avatares, pills
```

## 🌑 Elevación

```dart
AppElevation.none = 0   // Elementos planos
AppElevation.xs   = 2   // Elementos sutiles
AppElevation.sm   = 4   // Cards estándar
AppElevation.md   = 8   // Cards destacados
AppElevation.lg   = 16  // Modales, dialogs
```

## 🧩 Componentes

### Botones

#### PrimaryButton
**Uso**: Acciones principales (guardar, confirmar, crear)

```dart
PrimaryButton(
  onPressed: () {},
  label: 'Guardar',
  icon: Icons.save,        // Opcional
  isLoading: false,        // Muestra spinner
  isFullWidth: false,      // Expande al 100%
  backgroundColor: null,   // Color custom
)
```

**Estados**: Normal, Hover, Pressed, Loading, Disabled

#### SecondaryButton
**Uso**: Acciones secundarias (cancelar, volver)

```dart
SecondaryButton(
  onPressed: () {},
  label: 'Cancelar',
  icon: Icons.close,
  isLoading: false,
  isFullWidth: false,
  color: null,  // Color del borde y texto
)
```

**Visual**: Outlined, fondo transparente, borde 1.5px

#### AppTextButton
**Uso**: Acciones terciarias, enlaces inline

```dart
AppTextButton(
  onPressed: () {},
  label: 'Ver más',
  icon: Icons.arrow_forward,
  isUnderlined: true,  // Texto subrayado
  color: null,
)
```

**Visual**: Mínimo, sin fondo ni borde

### Inputs

#### AppTextField
**Uso**: Entrada de texto con validación

```dart
AppTextField(
  label: 'Email',
  controller: controller,
  hintText: 'usuario@ejemplo.com',
  helperText: 'Formato: email@dominio.com',
  errorText: null,  // Mensaje de error
  prefixIcon: Icons.email,
  suffixIcon: null,
  validator: (value) => null,
  obscureText: false,  // Para contraseñas
  enabled: true,
  maxLines: 1,
  keyboardType: TextInputType.emailAddress,
)
```

**Estados**: Normal, Focused (borde azul 2px), Error (borde rojo), Disabled

**Características**:
- Password toggle automático si `obscureText: true`
- Validación en tiempo real cuando hay error
- Helper text desaparece al mostrar error
- Colores dinámicos del icono según estado

### Cards

#### AppCard
**Uso**: Contenedor de información agrupada

```dart
AppCard(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  elevation: 4,
  color: null,
  borderRadius: 12,
  onTap: () {},  // Hace el card interactivo
  child: Widget,
)
```

**Variantes**:
- Default: Elevación sutil, sin interacción
- Interactive: Con `onTap`, efecto InkWell
- Custom: Color de fondo personalizado

### Feedback

#### AppLoadingIndicator
**Uso**: Estados de carga

```dart
AppLoadingIndicator(
  message: 'Cargando vehículos...',
  size: 48,
  color: AppColors.primary,
)
```

**Visual**: CircularProgressIndicator centrado con mensaje opcional

#### AppErrorWidget
**Uso**: Estados de error con opción de reintentar

```dart
AppErrorWidget(
  message: 'No se pudo cargar la información',
  onRetry: () {},  // Opcional
  retryLabel: 'Reintentar',
)
```

**Visual**: Icono de error, mensaje, botón de retry opcional

#### AppEmptyState
**Uso**: Listas vacías, sin resultados

```dart
AppEmptyState(
  message: 'No hay vehículos registrados',
  icon: Icons.directions_car_outlined,
  actionLabel: 'Agregar Vehículo',
  onAction: () {},  // Opcional
)
```

**Visual**: Icono grande, mensaje, acción opcional

## 🎭 Temas

### Implementación

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,  // Sigue config del sistema
)
```

### Componentes Temados

El `AppTheme` configura automáticamente:
- ✅ AppBar (transparente, sin sombra)
- ✅ Buttons (Elevated, Text, Outlined)
- ✅ Inputs (borders, labels, errores)
- ✅ Cards (elevación, bordes, sombras)
- ✅ Dialogs y BottomSheets
- ✅ SnackBars
- ✅ Progress Indicators
- ✅ Switch, Checkbox, Radio
- ✅ NavigationBar y FAB

## ♿ Accesibilidad

### Contraste de Colores
- ✅ Todos los colores cumplen WCAG 2.1 AA
- Texto sobre fondo claro: ratio mínimo 4.5:1
- Texto sobre fondo oscuro: ratio mínimo 4.5:1

### Tamaños Mínimos
- Botones: 48x48dp (Material Design)
- Áreas táctiles: mínimo 48x48dp
- Texto: mínimo 12px (caption)

### Soporte de Temas
- ✅ Light Mode
- ✅ Dark Mode
- ✅ Ajuste automático según sistema

## 📚 Widgetbook

### Ejecutar Showcase

```bash
flutter run -t widgetbook/main.dart
```

### Características
- ✅ Todos los componentes documentados
- ✅ Todas las variantes visuales
- ✅ Light/Dark theme toggle
- ✅ Diferentes tamaños de dispositivos
- ✅ Escalas de texto (1.0x, 1.5x, 2.0x)

### Estructura

```
widgetbook/
├── main.dart                  # App principal de Widgetbook
├── buttons_showcase.dart      # Variantes de botones
├── inputs_showcase.dart       # Variantes de inputs
├── cards_showcase.dart        # Variantes de cards
└── feedback_showcase.dart     # Variantes de feedback
```

## 🔧 Uso en Código

### Importar Componentes

```dart
// Tema
import 'package:smartfleetpro/shared/theme/app_theme.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

// Botones
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/secondary_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/app_text_button.dart';

// Inputs
import 'package:smartfleetpro/shared/widgets/inputs/app_text_field.dart';

// Cards
import 'package:smartfleetpro/shared/widgets/cards/app_card.dart';

// Feedback
import 'package:smartfleetpro/shared/widgets/feedback/app_loading_indicator.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_error_widget.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_empty_state.dart';
```

### Ejemplo Completo

```dart
import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';
import 'package:smartfleetpro/shared/widgets/cards/app_card.dart';
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehículo ABC-123',
            style: AppTextStyles.heading3(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Toyota Corolla 2020',
            style: AppTextStyles.bodyMedium(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            onPressed: () {},
            label: 'Ver Detalles',
            icon: Icons.visibility,
          ),
        ],
      ),
    );
  }
}
```

## 📖 Referencias

- [Material Design 3](https://m3.material.io/)
- [Flutter Material Components](https://docs.flutter.dev/ui/widgets/material)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Google Fonts](https://fonts.google.com/)

---

**Última actualización**: 2024
**Versión**: 1.0.0
**Mantenedores**: Equipo SmartFleet Pro
