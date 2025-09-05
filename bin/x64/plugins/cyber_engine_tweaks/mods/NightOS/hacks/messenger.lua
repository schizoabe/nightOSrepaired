messengerMod = {
    text = {
        {
            text = "[receiver] : Tu l'as revu ?\nKasiya : Non, je crois pas.\n[receiver] : Mais merde, qu'est-ce qu'il fout putain.\nKasiya : Je sais pas, il a donné aucun signe depuis plusieurs jours.\n[receiver] : Bon écoute, je vais poser un contrat pour le retrouver, pendant ce temps ne te fais pas trop remarquer.\nKasiya : D'accord..."
        },
        {
            text = "[receiver] : C'était carrément trop dingue !\nEddie : Trop ! Faudrait qu'on se refasse ça un jour !\n[receiver] : Ouai juste je reprends pas encore Pel' elle a encore fait une overdose...\nEddie : ça c'est sûr, elle sait pas se tenir, c'est triste. Je viens de regarder et il y en a encore un samedi à Pacifica, tu y seras ?\n[receiver] : Sans hésiter ! Je prends Vero et Clara avec moi ?\nEddie : Vas-y ! On se voit samedi."
        },
        {
            text = "Numéro Inconnu : Je sais ce que tu as fais.\n[receiver] : Euh.. Bonjour déjà ?\nNuméro Inconnu : Pour 400 eddies, je ne dévoilerai pas ton secret\n[receiver] : J'ai fais quoi au juste ? Tu fais flipper.\nNuméro Inconnu : Tu fais bien d'avoir peur, je te laisse jusqu'à la fin de la semaine pour verser les eddies sur ce compte : $1$PSCj7LpebDxvKJa3q6zJWjWGZZyJmT9hX, sinon je dirais à tous le monde ce qui est arrivé à Sarah.\n[receiver] : Comment tu sais ? Qui te l'as dis\nNuméro Inconnu: Je sais beaucoup de choses sur toi, tu as jusqu'à la fin de la semaine."
        },
        {
            text = "Numéro Inconnu : Trouduc ! Tu penses que je t'ai pas vu avec ma femme !\n[receiver] : C'était l'objectif, j'ai bien baisé ta salope de femme pendant que tu regardais\nNuméro Inconnu : Fils de pute ! Je sais où tu habites, je vais buter !\n[receiver] : Viens quand tu veux."
        },
        {
            text = "Rachel : hé [receiver] tu te rapeles la fois ou tu tes pisser tsu après avoir trop bu????\n[receiver] : Euh, oui, pourquoi ?\nRachel : parceke sa vien de m'ariver c trè humilian ahah\n[receiver] : Tu es sûr que ça va ? Tu veux pas que je ramène chez toi ?\nRachel : mais non sa va tqt\n[receiver] : Tu dis ça quand ça va pas bien généralement, dis-moi où tu es.\nRachel : bon okok tu vois le bar en face de l'epicerie asiat a kabuto\n[receiver] : Oui ?\nRachel : Bah jsui la, je t'attend laba.\n[receiver] : Bouge pas j'arrive.\nRachel : J'risque pas d'bouger tqt je suis tellement bourrée que jarrive meme plu a me lever"
        },
        {
            text = "[receiver] : T'en veux une bonne ?\nJean : Je suis occupé là...\n[receiver] : Okok... Pourquoi les chiens se lèchent-ils le sexe ?\nJean : J'en sais rien...\n[receiver] : Parcequ'ils le peuvent ! ahahah\nJean : Tu m'as vraiment fais chier juste pour ça ?\n[receiver] : Oui !"
        },
    }
}

function messengerMod.randomMessage(npcName)
    local s = messengerMod.text[RandRange(1, 7)].text
    local RnpcName = messengerMod.Split(npcName, " ")[1]
    return s:gsub("%[receiver]", RnpcName)
end

function messengerMod.Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
return messengerMod