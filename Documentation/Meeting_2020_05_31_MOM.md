* eType = 0: Our guy called someone or someone called him -> keep both
* eType = 1: Our guy mailed someone or someone mailed him -> keep both
* eType = 2: Our guy bought an item -> (should we keep all the people who also sold or bought this item?)
* eType = 3: Our guy sold an item -> (should we keep all the people who also sold or bought this item?)

* Modify:
  * only check for the exact person who sold him that thing or bought sth from him

* eType = 4:
  * (1) Our guy published a paper with some people: 3 other papers[check the template and see how many authors are there for each paper] [dendogram]
  * (2) Our paper had some authors(5 other authors + our guy): keep both
* eType = 5: consider the 29 categories- Source is a person we keep the Source
  * Target is a person we keep the Target

* eType = 6: Our guy travelled somewhere at some time
    * check the Template
    * possibly write an algorithm


* Other considerations
>* The person that we keep: we add all the rest of the categories
>* check the travel habits--
>* check Procurement channel in all of them
>* check co-authorship and Travel and Procurement in Template:
  - how they are connect
  - Travel: check times
  - Procurement: who sold to whom
  - Co-authorship: Are all the publishers in the data (the -99 specially)
>* Didn't check the Template in the big graph
>* Check Graph of Q1 in the big graph
