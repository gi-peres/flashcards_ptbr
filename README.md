# Flashcards PT-BR

![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Firestore-orange?logo=firebase)
![Gemini AI](https://img.shields.io/badge/Gemini-AI-red)
![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow)

## Briefing

Aplicativo educativo que revoluciona o aprendizado de vocabulário em português, inspirado no universo cinematográfico de Matrix. O **Flashcards PT-BR** combina inteligência artificial para gerar palavras desafiadoras e avaliação inteligente de respostas, permitindo que você construa uma coleção personalizada de palavras importantes. Perfeito para estudantes e profissionais que desejam expandir seu vocabulário de forma divertida, imersiva e interativa.

![Matrix Theme](assets/gifs/matrix.gif)

---

## Funcionalidades

- Geração Inteligente de Palavras — IA (Gemini) gera palavras únicas e seus significados em tempo real
- Avaliação Semântica — IA analisa sua resposta e retorna porcentagem + feedback detalhado
- Três Níveis de Dificuldade — TRINITY (fácil), MORPHEUS (médio), NEO (difícil)
- Coleção de Palavras Pessoal — Salve palavras diretamente no Firestore
- Gerenciamento Completo — Criar, editar, excluir palavras da sua coleção
- Autenticação Firebase — Login seguro com Firebase Auth
- Interface Temática — Design Matrix com cores verde/preto para imersão total

---

## Tecnologias Utilizadas

| Categoria | Tecnologia |
| Framework | Flutter 3.7+ |
| Linguagem | Dart |
| Backend | Firebase (Auth + Firestore) |
| IA | Google Gemini API |
| UI | Material Design |
| Gerenciamento de Estado | StatefulWidget/StatelessWidget |

---

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- Flutter SDK — [Baixar Flutter](https://flutter.dev/docs/get-started/install)
- Dart — (incluído com Flutter)
- Git — [Baixar Git](https://git-scm.com/download)
- Conta Firebase — [Criar em console.firebase.google.com](https://console.firebase.google.com)
- Editor — VS Code, Android Studio ou outro de sua preferência

### Verificar instalação

```bash
flutter --version
dart --version
git --version
```

---

## Instalação

### 1. Clonar o Repositório

```bash
git clone https://github.com/seu-usuario/flashcards-ptbr.git
cd flashcards-ptbr
```

### 2. Instalar Dependências

```bash
flutter pub get
```

### 3. Configurar Firebase

1. Acesse [Firebase Console](https://console.firebase.google.com)
2. Crie um novo projeto ou selecione um existente
3. Adicione um app Flutter ao projeto
4. Baixe o arquivo de configuração gerado
5. Coloque as credenciais em `lib/firebase_options.dart` (o arquivo já existe)

**Configuração de exemplo:**
```dart
static FirebaseOptions get currentPlatform {
  return FirebaseOptions(
    apiKey: "SEU_API_KEY",
    authDomain: "seu-projeto.firebaseapp.com",
    projectId: "seu-projeto",
    storageBucket: "seu-projeto.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abcdef123456",
  );
}
```

### 4. Configurar Firestore

1. No Firebase Console → Firestore Database → Criar banco de dados
2. Escolha modo adqueado

### 5. Executar o App

```bash
flutter run
```

Para executar em um navegador específico:
```bash
flutter run -d chrome
```

---

## Como Usar

### Fluxo Principal

1. Login/Registro — Crie uma conta ou faça login com email
2. Escolha de Dificuldade — Selecione TRINITY, MORPHEUS ou NEO
3. Arena — Veja a palavra e tente adivinhar o significado
4. Oráculo — Receba análise IA com porcentagem e feedback
5. Coleção — Adicione a palavra à sua coleção pessoal (opcional)

### Exemplo de Uso

#### Iniciar um Desafio
```bash
flutter run
# 1. Faça login
# 2. Clique em "TRINITY" para começar no nível fácil
# 3. Digite o significado da palavra exibida
# 4. Clique "SUBMETER AO ORÁCULO"
```

#### Gerenciar Coleção
- Acessar: Clique em "Minhas Coleções" no menu principal
- Adicionar: Clique no botão + ou após cada avaliação
- Editar: Clique no ícone de editar ao lado de uma palavra
- Deletar: Deslize a palavra para a direita ou clique no ícone de deletar

---

## Configurações Avançadas

### Trocar Modelo de IA

Edite `lib/gemini_service.dart`:

```dart
final model = FirebaseAI.googleAI().generativeModel(
  model: 'gemini-2.0-flash-lite', // Mudar aqui
);
```

**Opções disponíveis:**
- gemini-3-pro-preview
- gemini-3-flash-preview
- gemini-2.5-pro
- gemini-2.5-flash
- gemini-2.5-flash-lite

Link para consulta: https://firebase.google.com/docs/ai-logic/models?hl=pt-br

---

## Estrutura do Projeto

```
flashcards_ptbr/
├── lib/
│   ├── main.dart                    # Ponto de entrada
│   ├── app.dart                     # Configuração de rotas
│   ├── firebase_options.dart        # Credenciais Firebase
│   ├── gemini_service.dart          # Integração com IA
│   ├── login_page.dart               # Tela de login
│   ├── register_page.dart            # Tela de registro
│   ├── difficulty_page.dart          # Escolha de dificuldade
│   ├── arena_page.dart              # Desafio de palavra
│   ├── oracle_page.dart             # Resultado e feedback
│   ├── collections_words_page.dart  # Lista de palavras salvas
│   ├── vocabulary_word_model.dart   # Modelo de dados
│   └── widgets/                     # Componentes reutilizáveis
├── assets/
│   ├── gifs/                        # Animações
│   └── matrix/                      # Recursos temáticos
├── pubspec.yaml                     # Dependências
└── README.md                        # Este arquivo
```

---

## Troubleshooting

### Erro: permission-denied ao salvar palavras
Solução: Verifique se as regras Firestore foram publicadas corretamente.

### Erro: quota exceeded na IA
Solução: Você atingiu o limite gratuito (20 req/min). Aguarde 15 segundos ou upgrade para plano pago.

### Erro: App não conecta ao Firebase
Solução: Verifique as credenciais em firebase_options.dart e se o Firestore está ativado.

---

Desenvolvido com dedicação para aprendizado de vocabulário em português
