programa {
	inclua biblioteca Arquivos
	inclua biblioteca Util
	inclua biblioteca Tipos
	
	caracter tabuleiro[][] = 	{{' ', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
								,{'1', '+', ' ', '+', ' ', '+', ' ', '+', ' ', '+'}
								,{'2', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
								,{'3', '+', ' ', '+', ' ', '+', ' ', '+', ' ', '+'}
								,{'4', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
								,{'5', '+', ' ', '+', ' ', '+', ' ', '+', ' ', '+'}
								,{'6', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
								,{'7', '+', ' ', '+', ' ', '+', ' ', '+', ' ', '+'}
								,{'8', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
								,{'9', '+', ' ', '+', ' ', '+', ' ', '+', ' ', '+'}}

	inteiro pontos_humano = 0
	inteiro pontos_maquina = 0


	funcao logico pontua(inteiro linha, inteiro coluna, cadeia jogador) {
		logico pontuou = falso
		se ((linha < 2 ou linha > 8) ou ( coluna < 2 ou coluna > 8 )) {
			pontuou = falso
		} senao {
			se (tabuleiro[linha+1][coluna] != ' ' e tabuleiro[linha-1][coluna] != ' ' e tabuleiro[linha][coluna+1] != ' ' e tabuleiro[linha][coluna-1] != ' ' ){
				se (jogador == "humano") {
					pontos_humano += 1
					tabuleiro[linha][coluna] = 'H'
					pontuou = verdadeiro
				} senao {
					pontos_maquina += 1
					tabuleiro[linha][coluna] = 'M'
					pontuou = verdadeiro
				}
			}
		}
		retorne pontuou
	}

	funcao verifica_ponto(inteiro linha, inteiro coluna, cadeia jogador) {
		logico pontuou = falso
		se ( linha%2 != 0 ) {
			se (pontua(linha-1, coluna, jogador) ou pontua(linha+1, coluna, jogador) ) {
				pontuou = verdadeiro
			}
		} senao {
			se (pontua(linha, coluna-1, jogador) ou pontua(linha, coluna+1, jogador)) {
				pontuou = verdadeiro
			}
		}
		
		se (pontuou e jogador == "humano") {
			jogar_humano()		// ao pontuar, joga novamente
		} senao se (pontuou e jogador != "humano") {
			jogar_maquina()		// ao pontuar, joga novamente
		}
	}

	funcao logico jogar (inteiro posicao, cadeia jogador) {
		inteiro linha = posicao/10
		inteiro coluna = posicao%10

		se ( (posicao < 12 ou  posicao > 98) ou ( linha%2 != 0 e coluna%2 != 0 ) ou ( linha%2 == 0 e coluna%2 == 0 ) ) {
			retorne falso
		}
		senao se (tabuleiro[linha][coluna] == ' ') {
			se (jogador == "humano") {
				se (linha%2 != 0) {
					tabuleiro[linha][coluna] = '-'
				} senao {
					tabuleiro[linha][coluna] = '|'
				}
			} senao {
				se (linha%2 != 0) {
					tabuleiro[linha][coluna] = '~'
				} senao {
					tabuleiro[linha][coluna] = '!'
				}
			}
			verifica_ponto(linha, coluna, jogador)
			retorne verdadeiro
		}
		retorne falso
	}

	funcao salvar_jogo(logico turno) {
		inteiro save = Arquivos.abrir_arquivo("save.txt", Arquivos.MODO_ESCRITA)
		Arquivos.escrever_linha("# Pontos humano", save)
		Arquivos.escrever_linha( Tipos.inteiro_para_cadeia(pontos_humano, 10) , save)

		Arquivos.escrever_linha("# Pontos máquina", save)
		Arquivos.escrever_linha( Tipos.inteiro_para_cadeia(pontos_maquina, 10) , save)

		Arquivos.escrever_linha("# Turno", save)
		Arquivos.escrever_linha( Tipos.logico_para_cadeia(turno) , save)

		Arquivos.escrever_linha("# Tabuleiro", save)
		para (inteiro i = 0; i < 10; i++) {
			para (inteiro j = 0; j < 10; j++) {
				Arquivos.escrever_linha( Tipos.caracter_para_cadeia(tabuleiro[i][j]), save)
			}
		}

		Arquivos.fechar_arquivo(save)

		retorne
	}
	
	funcao carregar_jogo() {
		Arquivos.abrir_arquivo("save.txt", Arquivos.MODO_LEITURA)
		
	}
	
	funcao inteiro desenhar_inicio() {
		limpa()
		inteiro opcao = 9

		faca {
			limpa()
			escreva("#############################\n")
			escreva("##     Jogo dos Pontinhos  ##\n")
			escreva("#############################\n")
			escreva("##                         ##\n")
			escreva("##     1) Novo Jogo        ##\n")
			se (Arquivos.arquivo_existe("save.txt")) {
				escreva("##     2) Carregar Jogo    ##\n")
			} senao {
				escreva("##                         ##\n")
			}
			escreva("##     0) Sair             ##\n")
			escreva("##                         ##\n")
			escreva("#############################\n")
			escreva(">>>>>>>> Escolha uma opção: ")
			leia(opcao)

			se (opcao == 1 ) {
				retorne 1
			}
			senao se ( opcao == 2) {
				carregar_jogo()
				retorne 2
			}
			senao se (opcao == 0) {
				retorne 0
			}
		} enquanto (verdadeiro)

		
	}

	funcao desenhar_jogo() {
		limpa()

		escreva("########################\n")
		escreva("## Jogo dos pontinhos ##\n")
		escreva("########################\n")
		
		escreva("\n")

		//desenhar a matriz do tabuleiro
		para (inteiro i = 0; i < 10; i++) {
			para (inteiro j = 0; j < 10; j++) {
				escreva(tabuleiro[i][j], " ")
			}
			escreva( "\n")
		}

		escreva("\n")

		escreva(">>>>>>>>>>>>>>>> Placar <<<<<<<<<<<<<<<<\n")
		escreva("Jogador Humano - ", pontos_humano, " x ", pontos_maquina, " - Jogador Máquina\n")

	}

	funcao inteiro jogar_humano() {
		inteiro opcao = 1
		desenhar_jogo()
		
		escreva("\n-- Jogador humano --\n")
		escreva("Entre com uma posição (0 pra salvar e sair): ")
		leia(opcao)

		logico jogada = falso
		faca {
			se (opcao != 0) {
				jogada = jogar(opcao, "humano")
				se (nao jogada) {
					escreva("Jogada inválida, favor escolher outra posição: ")
					leia(opcao)
				}
			} senao {
				jogada = verdadeiro
			}
		} enquanto(nao jogada)
		retorne opcao
	}

	funcao inteiro jogar_maquina() {
		inteiro opcao = 1
		const inteiro jogadas[] = {12, 14, 16, 18,
										21, 23, 25, 27, 29,
										32, 34, 36, 38,
										41, 43, 45, 47, 49,
										52, 54, 56, 58,
										61, 63, 65, 67, 69,
										72, 74, 76, 78,
										81, 83, 85, 87, 89,
										92, 94, 96, 98}
		desenhar_jogo()
		
		escreva("\n-- Jogador máquina --\n")
		escreva("Entre com uma posição (0 pra salvar e sair): ")
		opcao = jogadas[Util.sorteia(0, 39)]
		Util.aguarde(1000)
		escreva(opcao, "\n")
		Util.aguarde(2000)

		logico jogada = falso
		faca {
			se (opcao != 0) {
				jogada = jogar(opcao, "máquina")
				se (nao jogada) {
					escreva("Jogada inválida, favor escolher outra posição: ")
					opcao = jogadas[Util.sorteia(0, 39)]
					Util.aguarde(1000)
					escreva(opcao, "\n")
					Util.aguarde(2000)
				}
			} senao {
				jogada = verdadeiro
			}
		} enquanto(nao jogada)
		retorne opcao
	}
	
	funcao inicio() {
		const logico HUMANO = verdadeiro
		const logico MAQUINA = falso
		logico turno = HUMANO

		inteiro opcao = desenhar_inicio()
		

		enquanto (opcao != 0 e (pontos_humano + pontos_maquina < 16) e (pontos_humano < 9 e pontos_maquina < 9)) {

			//turnos
			se (turno) {
				opcao = jogar_humano()
				se (opcao == 0) { salvar_jogo(turno) }
				turno = MAQUINA
			} senao {
				opcao = jogar_maquina()
				se (opcao == 0) { salvar_jogo(turno) }
				turno = HUMANO
			}
	
			
		}
		

		se ((pontos_humano + pontos_maquina > 15) ou (pontos_humano > 8 ou pontos_maquina > 8)) {
			escreva ("\n")
			se (pontos_humano > pontos_maquina) {
				escreva("Vitória do JOGADOR HUMANO!\n")
			} senao se (pontos_humano < pontos_maquina) {
				escreva("Vitória do JOGADOR MÁQUINA!\n")
			} senao {
				escreva("EMPATE!\n")
			}

			Arquivos.apagar_arquivo("save.txt")
		}
		


		
		
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3423; 
 * @DOBRAMENTO-CODIGO = [20, 40, 59, 86, 114, 151, 175, 198];
 */