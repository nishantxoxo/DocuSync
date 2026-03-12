const express = require('express');
const Document = require('../models/document');
const auth = require('../middlewares/auth')
const documentRouter = express.Router();

documentRouter.post('/doc/create', auth, async (req, res)=> {
    try {
        const {createdAt} = req.body;
        let document = new Document({
            uid: req.user,
            title: "Untitled Document",
            createdAt,
        });

        document = await document.save();

        res.json(document);
    } catch (error) {
        res.status(500).json({error: er.message});
        // res.status(500).j
    }
});

documentRouter.post('/doc/title', auth, async (req, res)=> {
    try {
        const {id, title} = req.body;
        const docu = await Document.findByIdAndUpdate(id, {title})

        // document = await document.save();

        res.json(document);
    } catch (error) {
        res.status(500).json({error: er.message});
        // res.status(500).j
    }
});


documentRouter.get('/docs/me', auth, async (req, res) => {
    try {
        let docs = await Document.find({uid: req.user})
        res.json(docs)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})


documentRouter.get('/doc/:id', auth, async (req, res) => {
    try {
        const docs = await Document.find(req.params.id)
        res.json(docs)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

module.exports = documentRouter;