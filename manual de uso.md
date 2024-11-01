Claro, aqui está a resposta em português:

### Manual de Uso para o Aplicativo CheckIt!

## Índice
1. Introdução
2. Instalação
3. Funcionalidades
4. Uso
5. Solução de Problemas
6. Informações de Contato

## 1. Introdução
O Aplicativo de Controle de Acesso é projetado para gerenciar e verificar presença em aulas com áreas restritas usando autenticação biométrica, verificação de localização e registro de tentativas de acesso. Ele integra-se com o Firebase para armazenamento seguro de dados e usa `flutter_map` para representação visual do mapa.

## 2. Instalação
### Pré-requisitos
- Certifique-se de ter o Flutter instalado em sua máquina.
- Configure o Firebase para o seu projeto.

### Passos
1. Clone o repositório:
   ```sh
   git clone https://github.com/IgorOliverx/somativa-flutter.git
   ```
2. Navegue até o diretório do projeto:
   ```sh
   cd somativa-flutter
   ```
3. Instale as dependências:
   ```sh
   flutter pub get
   ```
4. Configure o Firebase:
    - Siga as instruções no arquivo `firebase_options.dart` para configurar o Firebase para sua plataforma.
5. Execute o aplicativo:
   ```sh
   flutter run
   ```

## 3. Funcionalidades
- **Autenticação Biométrica e por Senha**: Usa `local_auth` para autenticação por impressão digital e login por senha.
- **Verificação de Localização**: Usa `geolocator` para verificar se o usuário está em uma área permitida.
- **Registro de Acessos**: Registra tentativas de acesso com data, hora e localização.
- **Mapa Visual**: Exibe a localização do usuário e áreas restritas usando `flutter_map`.

## 4. Uso
### Login
1. Abra o aplicativo.
2. Insira seu email e senha.
3. Clique em "Login".
4. Se a autenticação biométrica estiver habilitada, use sua impressão digital para realizar sua presença.


### Verificação de Localização
1. Após o login, o aplicativo verificará sua localização.
2. Certifique-se de estar dentro da área permitida para prosseguir.

### Registro de Acessos
1. Cada tentativa de acesso é registrada com detalhes relevantes.
2. Você pode visualizar seus registros de acesso no aplicativo.

### Visualização do Mapa
1. Navegue até a seção de mapa para ver sua localização atual e áreas restritas.
2. Use o mapa para garantir que você está dentro das zonas permitidas.

### Presença
1. Após a verificação de localização, você pode confirmar sua presença.

## 5. Solução de Problemas
### Problemas Comuns
- **Falha no Login**: Certifique-se de que seu email e senha estão corretos. Verifique sua conexão com a internet.
- **Falha na Verificação de Localização**: Certifique-se de que os serviços de localização estão habilitados no seu dispositivo e que você está dentro da área permitida.
- **Problemas com Autenticação Biométrica**: Certifique-se de que seu dispositivo suporta autenticação biométrica e que ela está configurada corretamente.

### Contato com Suporte
Se você encontrar algum problema, entre em contato com nossa equipe de suporte em support@accesscontrolapp.com.

## 6. Informações de Contato
Para mais assistência, você pode nos contatar em:
- **Email**: support@accesscontrolapp.com
- **Telefone**: +1-800-123-4567
- **Website**: www.accesscontrolapp.com

Este manual fornece uma visão geral básica do aplicativo e suas funcionalidades. Para informações mais detalhadas, consulte a seção de ajuda no aplicativo ou entre em contato com nossa equipe de suporte.