

# (Token -> movedToToken)
token_wtf_routine = []

# Wtf token checker
def wtf_token_checker(token, text):
    """
        Guarantees text does not squash tokens

    """
    text = wtf_morality_guard(text)

    """
    Token: [NL] => Newline tag
    """
    if token in text:
        """
        text: "Four score and
        seven beers ago," [NL]

        token:
            [NL] => [N-L]
        """
        l = len(Token)
        moveToken = Token[:l//2] + '-' + Token[l//2:]

        if moveToken in text:
        """
        Text: ...adds several nonlinearities
        into the equation [N-L] ...

        Token: [N-L] => [N-$L]
        """

            # [NL]-
            # [N-L] => [N$-L]
            i = l//2 + 1
            moveMoveToken = moveToken[:i] + '$' + moveToken[i:]

            if moveMoveToken in text:
            """
                Text: I take my illegal revenue to
                Norton's Money Laundering [N-$L]!

                # Okay, now you're just fucking with me.

                Token:
                    [N-$L] => [N-$cock69L]
            """

                moveMoveMoveToken = moveMoveToken[:i+1] +\
                    'cock69' + moveMoveToken[i+1:]

                """
                Recursively check for moving token.

                Text is guaranteed not to have
                    worst case scenario
                    by safety_guard().
                """
                text = wtf_token_checker(moveMoveMoveToken, text)

                text = text.replace(moveMoveToken, moveMoveMoveToken)
                token_wtf_routine.append((moveMoveToken, moveMoveMoveToken))
            text = text.replace(moveToken, moveMoveToken)
            token_wtf_routine.append((moveMoveToken, moveMoveMoveToken))
        text = text.replace(token, moveToken)
        token_wtf_routine.append((moveMoveToken, moveMoveMoveToken))
    # Text is guaranteed clear
    return text



def wtf_morality_guard(text):
    if '-$cock69-$cock69-$cock69' in text:
        # Do not un-replace token
        text = text.replace('-$cock69-$cock69-$cock69', 'Jesus Saves')
    return text
