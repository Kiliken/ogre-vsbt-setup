// check the plugin cfg before running
// add all include subfolder to cl too

#include <Ogre.h>
#include <OgreApplicationContext.h>
#include <OgreInput.h>
#include <OgreRTShaderSystem.h>

class BasicOgreApp 
    : public OgreBites::ApplicationContext
    , public OgreBites::InputListener
{
public:
    BasicOgreApp() : OgreBites::ApplicationContext("OgreTestApp"), headNode(nullptr) {}

    void setup() override {
        OgreBites::ApplicationContext::setup();
        addInputListener(this);

        Ogre::Root* root = getRoot();
        Ogre::SceneManager* scnMgr = root->createSceneManager();

        Ogre::RTShader::ShaderGenerator* shadergen = Ogre::RTShader::ShaderGenerator::getSingletonPtr();
        shadergen->addSceneManager(scnMgr);

        // Camera
        Ogre::Camera* cam = scnMgr->createCamera("MainCam");
        cam->setNearClipDistance(5);
        cam->setAutoAspectRatio(true);
        Ogre::SceneNode* camNode = scnMgr->getRootSceneNode()->createChildSceneNode();
        camNode->attachObject(cam);
        camNode->setPosition(0, 0, 200);
        getRenderWindow()->addViewport(cam);

        // Light
        Ogre::Light* light = scnMgr->createLight("MainLight");
        Ogre::SceneNode* lightNode = scnMgr->getRootSceneNode()->createChildSceneNode();
        lightNode->setPosition(20, 80, 50);
        lightNode->attachObject(light);

        // Ogre head entity
        Ogre::Entity* ogreHead = scnMgr->createEntity("Head", "ogrehead.mesh");
        headNode = scnMgr->getRootSceneNode()->createChildSceneNode();
        headNode->attachObject(ogreHead);
    }

    bool keyPressed(const OgreBites::KeyboardEvent& evt) override {
        if (evt.keysym.sym == OgreBites::SDLK_ESCAPE) {
            getRoot()->queueEndRendering();
        }
        if (evt.keysym.sym == OgreBites::SDLK_SPACE) { // lowercase 'w'
            if (headNode) {
                headNode->yaw(Ogre::Degree(-60));
            }
        }
        return true;
    }

private:
    Ogre::SceneNode* headNode; // member variable
};

int main(int argc, char** argv) {
    BasicOgreApp app;
    app.initApp();
    app.getRoot()->startRendering();
    app.closeApp();
    return 0;
}
 