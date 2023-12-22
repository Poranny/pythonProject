import clips
import PySimpleGUI as sg


def main():
    environment = clips.Environment()

    environment.load("online_games.clp")
    environment.reset()
    environment.run()

    message_template = environment.find_template('message')
    message = dict(list(message_template.facts())[0])

    BUTTON_KEYS = ['button0', 'button1', 'button2', 'button3', 'button4']
    TEXT_KEYS = ['text0', 'text1', 'text2', 'text3', 'text4']
    options = message['answers']

    radio_buttons = [[sg.Radio('', 1, key=BUTTON_KEYS[i], visible=(i < 4), default=(i == -1)),
                      sg.Text(options[i] if i < 4 else '', pad=(0, 0), font='Any 11', key=TEXT_KEYS[i])] for i in
                     range(4)]

    layout = [
        [sg.Text(message['question'], font=('Helvetica', 18), key='q')],
        radio_buttons,
        [sg.Button('Submit')]
    ]

    window = sg.Window("Find the right online game", layout, size=(700, 700))

    while True:
        event, values = window.read()
        if event == sg.WINDOW_CLOSED:
            break
        elif event == 'Submit':
            if len([x for x, y in values.items() if y is True]) > 0:
                value = [x for x, y in values.items() if y is True][0]
                environment.assert_string('({} "{}")'.format(message['name'], message['answers'][BUTTON_KEYS.index(value)]))
                environment.run()

                message_list = list(message_template.facts())

                if message_list:
                    message = dict(message_list[0])
                    window['q'].update(value=message['question'])

                    options = message['answers']
                    n = len(options)

                    for i in range(4):
                        window[BUTTON_KEYS[i]].update(value=False)
                        if i < n:
                            window[BUTTON_KEYS[i]].update(visible=True)
                            window[TEXT_KEYS[i]].update(value=options[i], visible=True)
                        else:
                            window[TEXT_KEYS[i]].update(visible=False)
                            window[BUTTON_KEYS[i]].update(visible=False)
                else:
                    window.close()
                    break

    environment.run()
    res_template = environment.find_template('online-game')

    try:
        result = dict(list(res_template.facts())[0])
    except IndexError:
        exit()

    result_layout = [
        [sg.Text(result['name'], font='Any 20', pad=(10, 10))],
        [sg.Button("Close", size=(10, 2), pad=(30, 30))]
    ]

    result_window = sg.Window("Found game for you", result_layout, size=(600, 200), element_justification='c')

    while True:
        event, values = result_window.read()
        if event == sg.WINDOW_CLOSED or event == "Close":
            break


if __name__ == "__main__":
    main()
