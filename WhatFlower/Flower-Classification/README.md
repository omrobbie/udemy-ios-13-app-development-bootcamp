# Flower Classification
Download this course resources [here](https://att-b.udemycdn.com/2018-07-02_18-48-43-c17b4a05c8f380a0c0a55d07b17b2b14/original.zip?secure=JxZuaejZqhZ4j_YmD7bFpw%3D%3D%2C1595229783&filename=Flower+Classifier.zip).

### Install pip

The first step is to make sure that we have the `pip` installed. Run this code on terminal.

```
pip -V
```

If we haven't install that yet, download `get-pip.py` from the Internet then installed it.

```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

sudo python get-pip.py
```

### Install coremltools

```
pip install -U coremltools
```

### Run the script

```
python convert-script.py
```

The result, it's create new file called `FlowerClassifier.mlmodel`.