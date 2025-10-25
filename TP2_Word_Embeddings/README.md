Voir 1.1.2
### Build Image
```
docker build -t myimage .
```

### launch a container
The -v option enable to share a directory between your host machine and the container. This will
enable you to edit files with your prefered script editor.
```
docker run -it --name nlp_tp1_container -v C:\Users\MB\SynologyDrive\COURS\Polytech\ET5\TAL\TP\ET5_TP_NLP\Word_Embeddings:/app myimage /bin/bash
```
LE build se fait grace au Dockerfile
### Relancer le docker plus tard

```
docker start nlp_tp1_container
```
```
docker exec -it nlp_tp1_container /bin/bash
```


## wikipedia substract data file  => wiki.en.gz