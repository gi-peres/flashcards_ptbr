import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verbum_app/login_page.dart';

void main() {
  
  // --- EXECUÇÃO 1: VALIDAÇÃO LOCAL (O teste que você viu falhar e agora vai passar) ---
  testWidgets('Execução 1: Deve mostrar aviso local se tentar logar com campos vazios', (WidgetTester tester) async {
    // Inicializa a tela de login
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Encontra o botão de entrar e clica sem preencher nada
    final botaoEntrar = find.text('ENTRAR NA MATRIX');
    await tester.tap(botaoEntrar);
    await tester.pumpAndSettle(); // Aguarda a animação do SnackBar aparecer

    // Procura o SnackBar de validação que adicionamos no código
    expect(find.text('Por favor, preencha todos os campos'), findsOneWidget);
  });


  // --- EXECUÇÃO 2: RETORNO DO SERVIDOR / FIREBASE (Cenário de erro de autenticação) ---
  /*testWidgets('Execução 2: Deve mostrar SnackBar com erro do Firebase quando a senha estiver errada', (WidgetTester tester) async {
    // Carrega a página no teste
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Simula o usuário digitando o email correto, mas a senha errada
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.hintText == 'Email_'), 'neo@matrix.com');
    await tester.enterText(find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.hintText == 'Senha_'), 'senha_errada_123');
    
    // Clica no botão para tentar logar
    final botaoEntrar = find.text('ENTRAR NA MATRIX');
    await tester.tap(botaoEntrar);
    await tester.pumpAndSettle();

    // Como a senha está errada, o Firebase vai disparar a FirebaseAuthException.
    // O teste valida se o seu 'ex.message!' foi exibido na tela vermelha do SnackBar.
    // (O mock do firebase_auth_mocks costuma retornar uma mensagem padrão de erro)
    expect(find.byType(SnackBar), findsOneWidget);
  });*/
}