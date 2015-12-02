programa {
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
	funcao carregar_jogo() {
		
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
			escreva("##                         ##\n")
			escreva("##     0) Sair             ##\n")
			escreva("##                         ##\n")
			escreva("#############################\n")
			escreva(">>>>>>>> Escolha uma op��o: ")
			leia(opcao)

			se (opcao == 1 ) {
				retorne 1
			}
			senao se ( opcao == 2) {
				carregar_jogo()
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
		escreva("Jogador Humano - ", pontos_humano, " x ", pontos_maquina, " - Jogador M�quina\n")

	}

	funcao inteiro jogar_humano() {
		inteiro opcao = 1
		desenhar_jogo()
		
		escreva("\n-- Jogador humano --\n")
		escreva("Entre com uma posi��o (0 pra salvar e sair): ")
		leia(opcao)

		logico jogada = falso
		faca {
			se (opcao != 0) {
				jogada = jogar(opcao, "humano")
				se (nao jogada) {
					escreva("Jogada inv�lida, favor escolher outra posi��o: ")
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
		desenhar_jogo()
		
		escreva("\n-- Jogador m�quina --\n")
		escreva("Entre com uma posi��o (0 pra salvar e sair): ")
		leia(opcao)

		logico jogada = falso
		faca {
			se (opcao != 0) {
				jogada = jogar(opcao, "m�quina")
				se (nao jogada) {
					escreva("Jogada inv�lida, favor escolher outra posi��o: ")
					leia(opcao)
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
		

		enquanto (opcao != 0 e (pontos_humano + pontos_maquina < 16)) {
			//desenhar_jogo()

			//turnos
			se (turno) {
				opcao = jogar_humano()
				turno = MAQUINA
			} senao {
				opcao = jogar_maquina()
				turno = HUMANO
			}
	
			
		}
		// salvar jogo e sair


		escreva ("\n")
		se (pontos_humano > pontos_maquina) {
			escreva("Vit�ria do JOGADOR HUMANO!\n")
		} senao se (pontos_humano < pontos_maquina) {
			escreva("Vit�ria do JOGADOR M�QUINA!\n")
		} senao {
			escreva("EMPATE!\n")
		}
		
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta se��o do arquivo guarda informa��es do Portugol Studio.
 * Voc� pode apag�-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1640; 
 */